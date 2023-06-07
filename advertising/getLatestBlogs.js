const axios = require('axios');
const fs = require('fs');
//const { exec } = require('child_process');
const util = require('util');
const logFilePath = 'hiveApiResult.txt';
const transformedLogFilePath = 'transformedForElasticSearch.txt';
const elasticsearchUrl = 'http://raspi:9200/hiveblogs/_bulk?';
const filterText = "Meetup";  // Hier den Suchtext für die Hiveblogs eingeben
const tag = 'deutsch'; // Hier den Hive-Tag eingeben (z.B. 'deutsch'), um die Suche einzugrenzen.
const limit = 100; // Hier wird die Anzahl der Blogs limitiert. Es werden nur die letzten $limit Blogs durchsucht.



// API-Endpunkt und Anfrageparameter
const url = 'https://api.hive.blog';
const requestData = {
  jsonrpc: '2.0',
  method: 'condenser_api.get_discussions_by_trending',
  params: [{ tag: tag, limit: limit }],
  id: 1,
};

// API-Anfrage senden
const hiveApiRequest = async () => {
  console.log("Aufruf der HIVE-API ...")
  axios.post(url, requestData, {
    headers: {
      'Content-Type': 'application/json',
    },
  })
    .then(response => {
      const result = response.data.result;
      // const filteredPosts = result.filter(post => post.body.includes('Achim is cool'));
      const filteredPosts = result.filter(post => post.body.includes(filterText));

      // Felder auswählen und in die Log-Datei schreiben
      const logData = filteredPosts.map(post => {
        return {
          author: post.author,
          title: post.title,
          created: post.created,
          url: post.url,
          post_id: post.post_id,
          filter: filterText,
          tag: tag
        };
      });
      fs.writeFileSync(logFilePath, JSON.stringify(logData, null, 2));
      console.log('Gefilterte Posts erfolgreich in die Log-Datei geschrieben.');
    })
    .catch(error => {
      console.error('Fehler bei der API-Anfrage:', error);
    });
    return Promise.resolve()
}

// Log-Daten lesen und transformieren
const readAndTransformLog = () => {
  const logData = fs.readFileSync(logFilePath, 'utf8');
  const parsedData = JSON.parse(logData);
  const transformedData = parsedData.flatMap((item) => [
    JSON.stringify({ index: { _index: 'hiveblogs', "_id": item.post_id } }),
    JSON.stringify(item),
    console.log("Logdata.... ", item.post_id)
  ]);

  return transformedData.join('\n');
};

// Transformierte Daten in "transformedForElasticSearch.txt" speichern
const saveTransformedLog = (transformedData) => {
  fs.writeFileSync(transformedLogFilePath, transformedData);
};

const SaveLog = async (transformedData) => {
  try {
    //const transformedData = readAndTransformLog();
    saveTransformedLog(transformedData);
    console.log('Log erfolgreich transformiert und in '+ transformedLogFilePath + ' gespeichert.');
  } catch (error) {
    console.error('Fehler:', error);
  }
};

// Transformierte Daten nach ElasticSearch hochladen
const postToElasticSearch = async () => {
 
  const transformedData = readAndTransformLog() + '\n';
  SaveLog(transformedData);
  const request = util.promisify(require('request'));
  var options = {
    'method': 'PUT',
    'url': elasticsearchUrl,
    'headers': {
      'Content-Type': 'application/json'
    },
    body: transformedData
  };
  await request(options, function (error, response) {
    if (error) throw new Error(error);
    console.log(response.body);
  });
  return Promise.resolve()
}


// Main Skripte ausführen
const main = async () => {
  await hiveApiRequest();
 // await postToElasticSearch();  //ToDo: Das await wird nicht berücksichtigt. Habe hier aber schon einen Tag investiert.
     setTimeout(async () => {
    await postToElasticSearch();
   }, 7000);
};
main().catch(error => {
  console.error(`Fehler beim Ausführen des Hauptprogramms: ${error}`);
});
