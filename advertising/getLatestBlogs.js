const axios = require('axios');
const fs = require('fs');

// API-Endpunkt und Anfrageparameter
const url = 'https://api.hive.blog';
const requestData = {
  jsonrpc: '2.0',
  method: 'condenser_api.get_discussions_by_trending',
  params: [{ tag: 'hive', limit: 5 }],
  id: 1,
};

// API-Anfrage senden
axios.post(url, requestData, {
  headers: {
    'Content-Type': 'application/json',
  },
})
  .then(response => {
    const result = JSON.stringify(response.data);
    fs.writeFileSync('log.txt', result); // Schreibe das Ergebnis in die Log-Datei
    console.log('API-Antwort erfolgreich in die Log-Datei geschrieben.');
  })
  .catch(error => {
    console.error('Fehler bei der API-Anfrage:', error);
  });
