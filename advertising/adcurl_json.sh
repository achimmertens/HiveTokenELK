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
TOKEN="advertising"
echo "Token = "$TOKEN
DATE=`date -I`
echo "DATE = "$DATE
LOGPATH="/home/pi/elk/$TOKEN/log"
echo "LOGPATH = "$LOGPATH
CMC="$LOGPATH/coinmarketcap.tmp"
echo "CMC = "$CMC
HIVEPRICE="$LOGPATH/hiveprice.tmp"
echo "HIVEPRICE = "$HIVEPRICE
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
CHARYDOLLAR="$LOGPATH/charydollar.tmp"
echo "CHARYDOLLAR = "$CHARYDOLLAR


# Get Hive/US-Dollar value
# curl -H "X-CMC_PRO_API_KEY: a1ff4bd0-2ac9-4700-ae61-6eaa62f56adc" -H "Accept: application/json" -d "symbol=HIVE" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/info > $CMC 

# Get json file from api engine:
curl -XPOST -H "Content-type: application/json" -d '{"jsonrpc":"2.0", "method":"condenser_api.get_discussions_by_trending", "params":[{"tag":"hive","limit":5}], "id":1}' 'https://api.hive.blog' > $LOG 
cat $LOG | sed -r 's/^.{34}//' | sed 's/.\{3\}$//' > $LOG1   # delete the first 34 and the last 3 characters
sed s/_id/id/g $LOG1 | sed s/\},\{\"id\"/=\{\"id\"/g | tr "=" "\n"  > $LOG2    # exchange "id" and insert newlines
sed s/$/\}/g $LOG2 > $LOG3     # Append } at the end of each line

# By extracting the IDs and setting it to the field "_id", we make sure, that all entires are unique:
cat $LOG3 | awk -F':' '{print $2}'| awk -F',' '{print $1}' | grep -v index > $INDEXLOG  # Extrahiere IDs
cat $INDEXLOG | awk '{print "{\"index\": {\"_index\":\"chary\",\"_id\":\"" $1 "\"}}="'} > $INDEXLOG2  # Füge Text ein
paste $INDEXLOG2 $LOG3 > $INDEXLOG3
sed s/=/=/g $INDEXLOG3 | tr "=" "\n" > $LOGDATE # Ersetze "=" durch Cariege Return 
cat $LOGDATE >> $LOGCONS    # Sammle die Daten in einem Topf

# ---- calculating Hiveprice ----
HIVEPRICE=`cat $CMC  | awk -F'price of Hive is' '{print $2}' | awk -F'USD ' '{print $1}'`
echo "The price of \$USD/\$HIVE = "$HIVEPRICE 
echo "The price of \$USD/\$HIVE = "$HIVEPRICE > $CHARYDOLLAR
CHARYPRICELIST=`cat $LOG3 | awk -F'price\":\"' '{print $2}' | awk -F'\"' '{print $1}'`
CHARYPRICE=`echo $CHARYPRICELIST | awk -F ' ' '{print $NF}'`
echo "The price of \$HIVE/\$CHARY = " $CHARYPRICE
echo ". The price of \$HIVE/\$CHARY = " $CHARYPRICE >> $CHARYDOLLAR
CHARY_DOLLAR=`echo $CHARYPRICE \* $HIVEPRICE|bc`
echo "The price of \$USD/\$CHARY = "$CHARY_DOLLAR
echo ". The price of \$USD/\$CHARY = " $CHARY_DOLLAR >> $CHARYDOLLAR
sudo cat $CHARYDOLLAR >> /var/www/html/elk/index.html    # Put the result to the web
# Upload the complete json data into kibana:
curl --location --request POST 'http://localhost:9200/chary/_bulk?' --header 'Content-Type: application/json' --data-binary @$LOGDATE
