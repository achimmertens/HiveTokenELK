In Kibana muss zuerst der Index wie folgt erstellt werden:
PUT hiveblogs
{
  "mappings": {
    "properties": {
      "author": {
        "type": "text"
      },
      "permlink": {
        "type": "text"
      },
      "title": {
        "type": "text"
      },
      "created": {
        "type": "date"
      },
      "url": {
        "type": "text"
      },
      "post_id": {
        "type": "keyword"
      },
      "filter": {
        "type": "keyword"
      },
      "tag": {
        "type": "keyword"
      }
    }
  }
}

Hiermit findet man die hochgeladenen Daten:
get hiveblogs/_search

Der Curl Befehl sieht wie folgt aus:
$ curl --location --request POST 'http://raspi:9200/hiveblogs/_bulk?' --header 'Content-Type: application/json' --data-binary @log3.txt

In Kibana einen Index Pattern erstellen:
Timestamp="created", Custom Index Pattern ID= hiveblogs_index_pattern_id
