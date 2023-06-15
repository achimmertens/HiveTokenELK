import hive from '@hiveio/hive-js';
import config from './config.js';
const privateKey = config.privateKey;
hive.api.setOptions({ url: 'https://api.hive.blog' });
const voter = 'anobel';
const author = 'achimmertens';
const permlink = 'wie-man-mit-javascript-in-die-hive-blockchain-schreibt';

hive.broadcast.vote(
  privateKey,
  voter,
  author,
  permlink,
  10000,
  function(err, result) {
    console.log(err, result);
  }
);