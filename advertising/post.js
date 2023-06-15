import fs from 'fs';
import hive from '@hiveio/hive-js';
import config from './config.js';

const privateKey = config.privateKey;
hive.api.setOptions({ url: 'https://api.hive.blog' });

const parentAuthor = ''; // Leer lassen, da es sich um einen eigenständigen Post handelt
const parentPermlink = 'eine-kopie-von-achimmertens'; // Permlink des Elternbeitrags, kann frei gewählt werden
const author = 'anobel';
const permlink = new Date().toISOString().replace(/[^a-zA-Z0-9]+/g, '').toLowerCase();
const title = 'Eine Kopie von achimmertens';
const bodyFilePath = './body.md';

// Den Inhalt der body.md-Datei lesen
const body = fs.readFileSync(bodyFilePath, 'utf-8');

hive.broadcast.comment(
  privateKey,
  parentAuthor,
  parentPermlink,
  author,
  permlink,
  title,
  body,
  { tags: ['test'], app: 'test/0.1' },
  function(err, result) {
    console.log(err, result);
  }
);
