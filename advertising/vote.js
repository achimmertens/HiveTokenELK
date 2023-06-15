import hive from '@hiveio/hive-js';
import config from './config.js';
const privateKey = config.privateKey;
hive.api.setOptions({ url: 'https://api.hive.blog' });
const voter = 'anobel';
const author = 'achimmertens';
const permlink = 'weekly-statistics-for-the-beerbot-rvz3l6';

hive.broadcast.vote(
  privateKey,
  voter,
  author,
  permlink,
  5000,
  function(err, result) {
    console.log(err, result);
  }
);