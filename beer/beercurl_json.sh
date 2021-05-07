#!/bin/sh
#
# This script collects data from the hive-engine API and puts them into kibana
#
# Written by Achim Mertens in April 2021
# Follow me on https://peakd.com/@achimmertens
# 

# Please create, if not exist, the folder /home/pi/elk/$TOKEN/log. I.e.:
# mkdir /home/pi/elk/chary/log
 
# Set some variables:
TOKEN="beer"
echo "Token = "$TOKEN
DATE=`date -I`
echo "DATE = "$DATE
LOGPATH="/home/pi/elk/$TOKEN/log"
echo "LOGPATH = "$LOGPATH
LOG="$LOGPATH/$TOKEN""curl.log"
echo "LOG = "$LOG
LOG1="$LOGPATH/$TOKEN""curl1.log"
echo "LOG1 = "$LOG1
LOG2="$LOGPATH/$TOKEN""curl2.log"
echo "LOG2 = "$LOG2
LOG3="$LOGPATH/$TOKEN""curl3.log"
echo "LOG3 = "$LOG3
LOGDATE="$LOGPATH/$TOKEN""curl_$DATE.log"
echo "LOGDATE = "$LOGDATE
LOGCONS="$LOGPATH/$TOKEN""curlcons.log"
echo "LOGCONS = "$LOGCONS
INDEXLOG="$LOGPATH/$TOKEN"_ids.log
echo "INDEXLOG = "$INDEXLOG
INDEXLOG2="$LOGPATH/$TOKEN"_ids2.log
echo "INDEXLOG2 = "$INDEXLOG2
INDEXLOG3="$LOGPATH/$TOKEN"_ids3.log
echo "INDEXLOG3 = "$INDEXLOG3

# Get json file from api engine:
curl -XPOST -H "Content-type: application/json" -d '{ "jsonrpc": "2.0", "method": "find", "params": { "contract": "market", "table": "tradesHistory", "query": { "symbol": "BEER"}, "limit":1000, "offset": 0 }, "id": 1 }' 'https://api.hive-engine.com/rpc/contracts' > $LOG

cat $LOG | sed -r 's/^.{34}//' | sed 's/.\{3\}$//' > $LOG1   # delete the first 34 and the last 3 characters
sed s/_id/id/g $LOG1 | sed s/\},\{\"id\"/=\{\"id\"/g | tr "=" "\n"  > $LOG2    # exchange "id" and insert newlines
sed s/$/\}/g $LOG2 > $LOG3     # Append } at the end of each line

# By extracting the IDs and setting it to the field "_id", we make sure, that all entires are unique:
cat $LOG3 | awk -F':' '{print $2}'| awk -F',' '{print $1}' | grep -v index > $INDEXLOG  # Extrahiere IDs
cat $INDEXLOG | awk '{print "{\"index\": {\"_index\":\"beer\",\"_id\":\"" $1 "\"}}="'} > $INDEXLOG2  # Füge Text ein
paste $INDEXLOG2 $LOG3 > $INDEXLOG3
sed s/=/=/g $INDEXLOG3 | tr "=" "\n" > $LOGDATE # Ersetze "=" durch Cariege Return 
cat $LOGDATE >> $LOGCONS    # Sammle die Daten in einem Topf

# Upload the complete json data into kibana:
curl --location --request POST 'http://localhost:9200/beer/_bulk?' --header 'Content-Type: application/json' --data-binary @$LOGDATE
