#!/bin/sh
#
# This script collects data from the hive-engine API and puts them into kibana
#
# Written by Achim Mertens in April 2021
# Follow me on https://peakd.com/@achimmertens
# 

# Please create, if not exist, the folder /home/pi/elk/$TOKEN/log. I.e.:
# mkdir /home/pi/elk/beer/log
 
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
echo "LOGDATE = "$LOG
LOGCONS="$LOGPATH/$TOKEN""curlcons.log"
echo "LOGCONS = "$LOGCONS
LOGCONSUNIQTEMP="$LOGPATH/$TOKEN""curlconsuniqtemp.log"
echo "LOGCONSUNIQ = "$LOGCONSUNIQTEMP
LOGCONSUNIQ="$LOGPATH/$TOKEN""curlconsuniq.log"
echo "LOGCONSUNIQ = "$LOGCONSUNIQ
TEXT1="{\"index\":"
TEXT2="{\"_index\":"
TEXT3="\"$TOKEN\"}}"

# Get json file from api engine:
curl -XPOST -H "Content-type: application/json" -d '{ "jsonrpc": "2.0", "method": "find", "params": { "contract": "market", "table": "tradesHistory", "query": { "symbol": "BEER"}, "limit":1000, "offset": 0 }, "id": 1 }' 'https://api.hive-engine.com/rpc/contracts' > $LOG

cat $LOG | sed -r 's/^.{34}//' | sed 's/.\{3\}$//' > $LOG1   # delete the first 34 and the last 3 characters
sed s/_id/id/g $LOG1 | sed s/\},\{\"id\"/=\{\"id\"/g | tr "=" "\n"  > $LOG2    # exchange "id" and insert newlines
sed s/$/\}/g $LOG2 > $LOGDATE     # Append } at the end of each line
echo " " >> $LOGDATE # Add new line at the end of the file
cat $LOGDATE >> $LOGCONS

# Now we have to eleminate the double entries in $LOGCONS
sort -u $LOGCONS > $LOGCONSUNIQTEMP

# Exchange some characters into newline +TEXT1 + newline:
sed s/\{\"id/$TEXT1\ $TEXT2\ $TEXT3=\{\"id/g $LOGCONSUNIQTEMP | tr "=" "\n"  > $LOGCONSUNIQ



# Upload the complete json data into kibana:
# curl --location --request POST 'http://localhost:9200/beer/_bulk?' --header 'Content-Type: application/json' --data-binary @$LOGCONSUNIQ 
