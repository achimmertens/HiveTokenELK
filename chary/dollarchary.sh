#!/bin/sh
#
# This script collects data from the coinmarketcap API and puts them into kibana
#
# Written by Achim Mertens in September 2021
# Follow me on https://peakd.com/@achimmertens
# 

 
# Set some variables:
TOKEN="chary"
echo "Token = "$TOKEN
DATE=`date -I`
echo "DATE = "$DATE
LOGPATH="/home/pi/elk/$TOKEN/log"
echo "LOGPATH = "$LOGPATH
CMC="$LOGPATH/coinmarketcap.tmp2"
echo "CMC = "$CMC
HIVEPRICE="$LOGPATH/hiveprice.tmp"
echo "HIVEPRICE = "$HIVEPRICE
DOLLARCHARY="$LOGPATH/dollarchary.json"
echo "DOLLARCHARY = "$DOLLARCHARY
LOG3="$LOGPATH/$TOKEN""curl3.log"
echo "LOG3 = "$LOG3

# Get Hive/US-Dollar value
curl -H "X-CMC_PRO_API_KEY: a1ff4bd0-2ac9-4700-ae61-6eaa62f56adc" -H "Accept: application/json" -d "symbol=HIVE" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/info > $CMC 




# ---- calculating Hiveprice ----
HIVEPRICE=`cat $CMC  | awk -F'price of Hive is' '{print $2}' | awk -F'USD ' '{print $1}'`
echo "The price of \$USD/\$HIVE = "$HIVEPRICE 
# echo "The price of \$USD/\$HIVE = "$HIVEPRICE > $CHARYDOLLAR
CHARYPRICELIST=`cat $LOG3 | awk -F'price\":\"' '{print $2}' | awk -F'\"' '{print $1}'`
CHARYPRICE=`echo $CHARYPRICELIST | awk -F ' ' '{print $NF}'`
echo "The price of \$HIVE/\$CHARY = " $CHARYPRICE
# echo ". The price of \$HIVE/\$CHARY = " $CHARYPRICE >> $CHARYDOLLAR
CHARY_DOLLAR=`echo $CHARYPRICE \* $HIVEPRICE|bc`
echo "The price of \$USD/\$CHARY = "$CHARY_DOLLAR
# echo ". The price of \$USD/\$CHARY = " $CHARY_DOLLAR >> $CHARYDOLLAR

echo "{\"index\": {\"_index\":\"dollartoken\"}} 
{\"token\":\"chary\",\"charyprice\":$CHARYPRICE}" > $DOLLARCHARY
# {"token":"chary","timestamp":1631274978,"usd_hive":"0.75","hive_token":"0.005","usd_token":"0.0037"}"







# Upload the complete json data into kibana:
# curl --location --request POST 'http://localhost:9200/chary/_bulk?' --header 'Content-Type: application/json' --data-binary @$LOGDATE
