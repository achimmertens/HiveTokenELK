import hive from '@hiveio/hive-js';
import config from './config.js';
const privateKey = config.privateKey;
hive.api.setOptions({ url: 'https://api.hive.blog' });
const parentAuthor = 'achimmertens';
const parentPermlink = 'wie-man-mit-javascript-in-die-hive-blockchain-schreibt';
const author = 'anobel';
const permlink = new Date().toISOString().replace(/[^a-zA-Z0-9]+/g, '').toLowerCase();
const title = '';
const body = 'Hallo Achim, dass sieht ja echt cool aus. Ichj kopiere mir mal deinen Text. Im übrigen wurde dieser Kommentar auch aus einem Javascript Programm geschrieben :-)';

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
