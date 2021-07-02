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
LOGPATH="/home/pi/elk/$TOKEN/logbot"
echo "LOGPATH = "$LOGPATH
CMC="$LOGPATH/coinmarketcap.tmp"
echo "CMC = "$CMC
HIVEPRICE="$LOGPATH/hiveprice.tmp"
echo "HIVEPRICE = "$HIVEPRICE
LOG="$LOGPATH/$TOKEN""botcurl.log"
echo "LOG = "$LOG
LOG1="$LOGPATH/$TOKEN""botcurl1.log"
echo "LOG1 = "$LOG1
LOG2="$LOGPATH/$TOKEN""botcurl2.log"
echo "LOG2 = "$LOG2
LOG3="$LOGPATH/$TOKEN""botcurl3.log"
echo "LOG3 = "$LOG3
LOG4="$LOGPATH/$TOKEN""botcurl4.log"
echo "LOG4 = "$LOG4
LOGDATE="$LOGPATH/$TOKEN""botcurl_$DATE.log"
echo "LOGDATE = "$LOGDATE
LOGCONS="$LOGPATH/$TOKEN""botcurlcons.log"
echo "LOGCONS = "$LOGCONS
INDEXLOG="$LOGPATH/$TOKEN"bot_ids.log
echo "INDEXLOG = "$INDEXLOG
INDEXLOG2="$LOGPATH/$TOKEN"bot_ids2.log
echo "INDEXLOG2 = "$INDEXLOG2
INDEXLOG3="$LOGPATH/$TOKEN"bot_ids3.log
echo "INDEXLOG3 = "$INDEXLOG3
BEERDOLLAR="$LOGPATH/beerdollar.tmp"
echo "BEERDOLLAR = "$BEERDOLLAR


# Get Hive/US-Dollar value
# curl -H "X-CMC_PRO_API_KEY: a1ff4bd0-2ac9-4700-ae61-6eaa62f56adc" -H "Accept: application/json" -d "symbol=HIVE" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/info > $CMC 

# Get json file from api engine:
curl -X 'GET' 'https://accounts.hive-engine.com/accountHistory?account=beerlover&limit=1000&offset=0&symbol=BEER' -H 'accept: application/xml' > $LOG
cat $LOG

cat $LOG | sed -r 's/^.{1}//' | sed 's/.\{1\}$//' > $LOG1   # delete the first and the last characters
sed s/_id/id/g $LOG1 | sed s/\},\{\"id\"/=\{\"id\"/g | tr "=" "\n"  > $LOG2    # exchange "id" and insert newlines
sed s/$/\}/g $LOG2 > $LOG3     # Append } at the end of each line

# By extracting the IDs and setting it to the field "_id", we make sure, that all entires are unique:
cat $LOG3 | awk -F':' '{print $2}'| awk -F',' '{print $1}' | grep -v index > $INDEXLOG  # Extrahiere IDs
cat $INDEXLOG | awk '{print "{\"index\": {\"_index\":\"beerbot\",\"_id\":" $1 "}}="'} > $INDEXLOG2  # Füge Text ein
paste $INDEXLOG2 $LOG3 > $INDEXLOG3
sed s/=/=/g $INDEXLOG3 | tr "=" "\n" > $LOG4 # Ersetze "=" durch Cariege Return 
cat $LOG4 | sed '$ s/.$//' > $LOGDATE  # Letztes Zeichen "}" löschen
cat $LOGDATE >> $LOGCONS    # Sammle die Daten in einem Topf

# ---- calculating Hiveprice ----
# HIVEPRICE=`cat $CMC  | awk -F'price of Hive is' '{print $2}' | awk -F'USD ' '{print $1}'`
# echo "The price of \$USD/\$HIVE = "$HIVEPRICE 
# echo "The price of \$USD/\$HIVE = "$HIVEPRICE > $BEERDOLLAR
# BEERPRICELIST=`cat $LOG3 | awk -F'price\":\"' '{print $2}' | awk -F'\"' '{print $1}'`
# BEERPRICE=`echo $BEERPRICELIST | awk -F ' ' '{print $NF}'`
# echo "The price of \$HIVE/\$BEER = " $BEERPRICE
# echo ". The price of \$HIVE/\$BEER = " $BEERPRICE >> $BEERDOLLAR
# BEER_DOLLAR=`echo $BEERPRICE \* $HIVEPRICE|bc`
# echo "The price of \$USD/\$BEER = "$BEER_DOLLAR
# echo ". The price of \$USD/\$BEER = " $BEER_DOLLAR >> $BEERDOLLAR
# sudo cat $BEERDOLLAR >> /var/www/html/elk/index.html    # Put the result to the web



# Upload the complete json data into kibana:
curl --location --request POST 'http://localhost:9200/beerbot/_bulk?' --header 'Content-Type: application/json' --data-binary @$LOGDATE
