# !/bin/bash
# Delete all old indicees in Kibana:

curl --location --request DELETE 'http://localhost:9200/beer' --header 'Content-Type: application/json'
curl --location --request DELETE 'http://localhost:9200/chary' --header 'Content-Type: application/json'
curl --location --request DELETE 'http://localhost:9200/leo' --header 'Content-Type: application/json'
curl --location --request DELETE 'http://localhost:9200/list' --header 'Content-Type: application/json'
curl --location --request DELETE 'http://localhost:9200/pob' --header 'Content-Type: application/json'
curl --location --request DELETE 'http://localhost:9200/sim' --header 'Content-Type: application/json'
curl --location --request DELETE 'http://localhost:9200/beerbot' --header 'Content-Type: application/json'
curl --location --request DELETE 'http://localhost:9200/spt' --header 'Content-Type: application/json'

# Insert for each token a new indice:
curl --location --request PUT 'http://localhost:9200/beer' --header 'Content-Type: application/json' --data-bin @put_index.json
curl --location --request PUT 'http://localhost:9200/chary' --header 'Content-Type: application/json' --data-bin @put_index.json
curl --location --request PUT 'http://localhost:9200/leo' --header 'Content-Type: application/json' --data-bin @put_index.json
curl --location --request PUT 'http://localhost:9200/list' --header 'Content-Type: application/json' --data-bin @put_index.json
curl --location --request PUT 'http://localhost:9200/pob' --header 'Content-Type: application/json' --data-bin @put_index.json
curl --location --request PUT 'http://localhost:9200/sim' --header 'Content-Type: application/json' --data-bin @put_index.json
curl --location --request PUT 'http://localhost:9200/beerbot' --header 'Content-Type: application/json' --data-bin @/home/pi/elk/beer/put_beerbot_index.ndjson
curl --location --request PUT 'http://localhost:9200/spt' --header 'Content-Type: application/json' --data-bin @put_index.json

# bulkload the consolidated data for each token
curl --location --request POST 'http://localhost:9200/beer/_bulk?' --header 'Content-Type: application/json' --data-binary @/home/pi/elk/beer/log/beercurlcons.log
curl --location --request POST 'http://localhost:9200/chary/_bulk?' --header 'Content-Type: application/json' --data-binary @/home/pi/elk/chary/log/charycurlcons.log
curl --location --request POST 'http://localhost:9200/leo/_bulk?' --header 'Content-Type: application/json' --data-binary @/home/pi/elk/leo/log/leocurlcons.log
curl --location --request POST 'http://localhost:9200/list/_bulk?' --header 'Content-Type: application/json' --data-binary @/home/pi/elk/list/log/listcurlcons.log
curl --location --request POST 'http://localhost:9200/pob/_bulk?' --header 'Content-Type: application/json' --data-binary @/home/pi/elk/pob/log/pobcurlcons.log
curl --location --request POST 'http://localhost:9200/sim/_bulk?' --header 'Content-Type: application/json' --data-binary @/home/pi/elk/sim/log/simcurlcons.log
curl --location --request POST 'http://localhost:9200/beerbot/_bulk?' --header 'Content-Type: application/json' --data-binary @/home/pi/elk/beer/logbot/beerbotcurlcons.log
curl --location --request POST 'http://localhost:9200/spt/_bulk?' --header 'Content-Type: application/json' --data-binary @/home/pi/elk/spt/log/sptcurlcons.log

# Now upload "All_kibana_objects.ndjson
# (maybe?) create the index patternview for each indice

# This is new and under construction:
# curl --location --request PUT 'http://localhost:9200/dollartoken' --header 'Content-Type: application/json' --data-bin @/home/pi/elk/chary/dollarcharyindex.json
# curl --location --request POST 'http://localhost:9200/dollartoken/_bulk?' --header 'Content-Type: application/json' --data-binary @/home/pi/elk/chary/log/dollarchary.ndjson