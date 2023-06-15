import hive from '@hiveio/hive-js';
import config from './config.js';

const privateKey = config.privateKey;
hive.api.setOptions({ url: 'https://api.hive.blog' });

const author = 'anobel';
const permlink = new Date().toISOString().replace(/[^a-zA-Z0-9]+/g, '').toLowerCase();
const title = 'Testpost';
const body = 'Hallo, hier ist anobel. Dies ist mein erster Post seit langem.';

const jsonMetadata = {
  tags: ['test'],
  app: 'test/0.1'
};

const operations = [
  [
    'comment',
    {
      parent_author: '',
      parent_permlink: 'test', // Ersetzen Sie 'test' durch den gewünschten Haupt-Tag
      author: author,
      permlink: permlink,
      title: title,
      body: body,
      json_metadata: JSON.stringify(jsonMetadata)
    }
  ]
];

hive.broadcast.send(
  {
    operations: operations,
    extensions: []
  },
  { posting: privateKey },
  function(err, result) {
    console.log(err, result);
  }
);
