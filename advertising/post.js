const fs = require('fs');
const hive = require('@hiveio/hive-js');
const steem = require('steem');
const config = require('./config.js');

const privateKey = config.privateKey;
//hive.api.setOptions({ url: 'https://api.hive.blog' });
hive.api.setOptions({ url: 'https://api.steem.blog' });

const parentAuthor = ''; // Leer lassen, da es sich um einen eigenständigen Post handelt
const parentPermlink = 'ein-test-von-achimmertens'; // Permlink des Elternbeitrags, kann frei gewählt werden
const author = 'achimmertens';
const permlink = new Date().toISOString().replace(/[^a-zA-Z0-9]+/g, '').toLowerCase();
const title = 'Eine Test von achimmertens';
const bodyFilePath = './body.md';

// Den Inhalt der body.md-Datei lesen
const body = fs.readFileSync(bodyFilePath, 'utf-8');

//hive.broadcast.comment(
steem.broadcast.comment(  
  privateKey,
  parentAuthor,
  parentPermlink,
  author,
  permlink,
  title,
  body,
  { tags: ['test'], app: 'test/0.1' },
  function(err, result) {
    if (err) {
      console.error(err);
    } else {
      console.log('Post erfolgreich erstellt:', result);
    }
  }
);
