import fs from 'fs';
import axios from 'axios';
import hive from '@hiveio/hive-js';
import config from './config.js';

const privateKey = config.privateKey;
hive.api.setOptions({ url: 'https://api.hive.blog' });

const parentAuthor = '';
const parentPermlink = 'test-mit-bildupload';
const author = 'anobel';
const permlink = new Date().toISOString().replace(/[^a-zA-Z0-9]+/g, '').toLowerCase();
const title = 'Test mit Bildupload';
const bodyFilePath = './body.md';
const imageFilePath = './Test.jpg';

// Den Inhalt der body.md-Datei lesen
const body = fs.readFileSync(bodyFilePath, 'utf-8');

// Funktion zum Hochladen des Bildes zu Backblaze B2
async function uploadImage() {
  try {
    const image = fs.readFileSync(imageFilePath);
    const response = await axios.post('https://api.backblazeb2.com/b2api/v2/b2_upload_file', image, {
      headers: {
        'Authorization': config.backblazeAuthToken,
        'Content-Type': 'b2/x-auto',
        'X-Bz-File-Name': 'Test.jpg',
        'Content-Length': image.length
      }
    });

    if (response.status === 200) {
      const imageUrl = response.data.fileUrl;
      console.log('BildURL = ', imageUrl);
      return imageUrl;
    } else {
      throw new Error('Fehler beim Hochladen des Bildes zu Backblaze B2.');
    }
  } catch (error) {
    throw new Error('Fehler beim Hochladen des Bildes: ' + error.message);
  }
}

// Den Upload des Bildes aufrufen und die URL erhalten
uploadImage()
  .then(imageUrl => {
    // Bild-URL in den Body einfügen
    const bodyWithImage = body.replace('[BILD_01]', `![Bild 01](${imageUrl})`);

    hive.broadcast.comment(
      privateKey,
      parentAuthor,
      parentPermlink,
      author,
      permlink,
      title,
      bodyWithImage,
      { tags: ['test'], app: 'test/0.1' },
      function(err, result) {
        if (err) {
          console.error('Fehler beim Erstellen des Kommentars:', err);
        } else {
          console.log('Kommentar erfolgreich erstellt.');
        }
      }
    );
  })
  .catch(error => {
    console.error('Fehler beim Hochladen des Bildes:', error);
  });
