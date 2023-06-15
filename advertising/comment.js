import hive from '@hiveio/hive-js';
import config from './config.js';
const privateKey = config.privateKey;
hive.api.setOptions({ url: 'https://api.hive.blog' });
const parentAuthor = 'achimmertens';
const parentPermlink = 'weekly-statistics-for-the-beerbot-rvz3l6';
const author = 'anobel';
const permlink = new Date().toISOString().replace(/[^a-zA-Z0-9]+/g, '').toLowerCase();
const title = '';
const body = 'Hallo, hier ist anobel. Dies ist mein erster Kommentar seit langem.';

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
