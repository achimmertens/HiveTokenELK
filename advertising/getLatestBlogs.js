const axios = require('axios');
const fs = require('fs');
//const { exec } = require('child_process');
const util = require('util');



const logFilePath = 'log.txt';
const transformedLogFilePath = 'log3.txt';
const elasticsearchUrl = 'http://raspi:9200/_bulk';

// API-Endpunkt und Anfrageparameter
const url = 'https://api.hive.blog';
const requestData = {
  jsonrpc: '2.0',
  method: 'condenser_api.get_discussions_by_trending',
  params: [{ tag: 'deutsch', limit: 3 }],
  id: 1,
};

/*
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

    fs.writeFileSync(logFilePath, JSON.stringify(logData, null, 2));

    console.log('Gefilterte Posts erfolgreich in die Log-Datei geschrieben.');
  })
  .catch(error => {
    console.error('Fehler bei der API-Anfrage:', error);
  });

  */




  /*
  const { exec } = require('child_process');

const command = `jq -c '.[] | { "index": { "_index": "hiveblogs" } }, { "author": .author, "permlink": .permlink, "title": .title, "created": .created, "url": .url, "post_id": .post_id }' log.txt | paste -sd'\n' - | curl --location --request POST 'http://localhost:9200/_bulk' --header 'Content-Type: application/x-ndjson' --data-binary @-`;

exec(command, (error, stdout, stderr) => {
  if (error) {
    console.error(`Fehler beim Ausführen des jq-paste-curl-Befehls: ${error}`);
    return;
  }
  console.log('der jq-paste-curl-Befehl erfolgreich ausgeführt');
});
*/

// Schritt 1: Log-Daten lesen und transformieren
const readAndTransformLog = () => {
    const logData = fs.readFileSync(logFilePath, 'utf8');
    const parsedData = JSON.parse(logData);
  
    const transformedData = parsedData.flatMap((item) => [
      JSON.stringify({ index: { _index: 'hiveblogs' } }),
      JSON.stringify(item)
    ]);
  
    return transformedData.join('\n');
  };
  
  // Schritt 2: Transformierte Daten in log3.txt speichern
  const saveTransformedLog = (transformedData) => {
    fs.writeFileSync(transformedLogFilePath, transformedData);
  };
  
  // Hauptfunktion
  const transformAndSaveLog = () => {
    try {
      const transformedData = readAndTransformLog()+'\n';
      saveTransformedLog(transformedData);
      console.log('Log erfolgreich transformiert und in log3.txt gespeichert.');
    } catch (error) {
      console.error('Fehler:', error);
    }
  };
  
  // Skript ausführen
  transformAndSaveLog();


  
  const transformedData = readAndTransformLog()+'\n';
  var request = require('request');
  var options = {
    'method': 'POST',
    'url': 'http://raspi:9200/hiveblogs/_bulk?',
    'headers': {
      'Content-Type': 'application/json'
    },
    body: transformedData
  };


  request(options, function (error, response) {
    if (error) throw new Error(error);
    console.log(response.body);
  });




