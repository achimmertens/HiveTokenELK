#!/bin/bash

IDFILE=charycurl_ids.log
LOG=charycurl_2021-04-23.log

# while read TRANS; do
# while read ID; do
# echo $ID
# echo $TRANS
# n=$((n+1))
# done < $IDFILE
# done < $LOG


TOKEN="chary"
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
LOGDATE="$LOGPATH/$TOKEN""curl_test_$DATE.log"
echo "LOGDATE = "$LOG
LOGCONS="$LOGPATH/$TOKEN""curlcons.log"
echo "LOGCONS = "$LOGCONS
INDEXLOG="$LOGPATH/$TOKEN"_ids.log
echo "INDEXLOG = "$INDEXLOG
INDEXLOG2="$LOGPATH/$TOKEN"_ids2.log
echo "INDEXLOG2 = "$INDEXLOG2
INDEXLOG3="$LOGPATH/$TOKEN"_id3.log
echo "INDEXLOG3 = "$INDEXLOG3

TEXT1="{\"index\":"
TEXT2="{\"_index\":"
TEXT3="\"$TOKEN\"}}"


# sed s/_id/id/g $LOG1 | sed s/\},\{\"id\"/=\{\"id\"/g | tr "=" "\n"  > $LOG2    # exchange "id" and insert newlines
# sed s/$/\}/g $LOG2 > $LOG3     # Append } at the end of each line

cat $LOG3 | awk -F':' '{print $2}'| awk -F',' '{print $1}' | grep -v index > $INDEXLOG
cat $INDEXLOG | awk '{print "{\"index\": {\"_index\":\"chary\",\"_id\":\"" $1 "\"}}="'} > $INDEXLOG2
sed s/=/=/g $INDEXLOG2 | tr "=" "\n" > $INDEXLOG3
paste $INDEXLOG3 $LOG3 > $LOGDATE
# sed s/\{\"id/$TEXT1\ $TEXT2\ $TEXT3=\{\"id/g $LOG3 | tr "=" "\n"  > $LOGDATE

