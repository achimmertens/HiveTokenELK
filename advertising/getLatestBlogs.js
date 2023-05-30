const axios = require('axios');
const fs = require('fs');

// API-Endpunkt und Anfrageparameter
const url = 'https://api.hive.blog';
const requestData = {
  jsonrpc: '2.0',
  method: 'condenser_api.get_discussions_by_trending',
  params: [{ tag: 'deutsch', limit: 3 }],
  id: 1,
};

// API-Anfrage senden
axios.post(url, requestData, {
  headers: {
    'Content-Type': 'application/json',
  },
})
  .then(response => {
    const result = response.data.result;
   // const filteredPosts = result.filter(post => post.body.includes('Achim is cool'));
    const filteredPosts = result //.filter(post => post.body.includes('Achim is cool'));
    
    // Felder auswählen und in die Log-Datei schreiben
    const logData = filteredPosts.map(post => {
      return {
        author: post.author,
        permlink: post.permlink,
        title: post.title,
        created: post.created,
        url: post.url,
        post_id: post.post_id,
      };
    });

    fs.writeFileSync('log.txt', JSON.stringify(logData, null, 2));

    console.log('Gefilterte Posts erfolgreich in die Log-Datei geschrieben.');
  })
  .catch(error => {
    console.error('Fehler bei der API-Anfrage:', error);
  });

  const { exec } = require('child_process');

const command = `jq -c '.[] | { "index": { "_index": "hiveblogs" } }, { "author": .author, "permlink": .permlink, "title": .title, "created": .created, "url": .url, "post_id": .post_id }' log.txt | paste -sd'\n' - | curl --location --request POST 'http://localhost:9200/_bulk' --header 'Content-Type: application/x-ndjson' --data-binary @-`;

exec(command, (error, stdout, stderr) => {
  if (error) {
    console.error(`Fehler beim Ausführen des jq-paste-curl-Befehls: ${error}`);
    return;
  }
  console.log('der jq-paste-curl-Befehl erfolgreich ausgeführt');
});

