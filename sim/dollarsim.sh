#!/bin/sh
#
# This script collects data from the coinmarketcap API and puts them into kibana
#
# Written by Achim Mertens in September 2021
# Follow me on https://peakd.com/@achimmertens
# 

 
# Set some variables:
TOKEN="sim"
echo "Token = "$TOKEN
DATE=`date -I`
echo "DATE = "$DATE
LOGPATH="/home/pi/elk/$TOKEN/log"
echo "LOGPATH = "$LOGPATH
CMC="$LOGPATH/coinmarketcap.tmp2"
echo "CMC = "$CMC
HIVEPRICE="$LOGPATH/hiveprice.tmp"
echo "HIVEPRICE = "$HIVEPRICE
DOLLARTOKEN="$LOGPATH/dollartoken.json"
echo "DOLLARTOKEN = "$DOLLARTOKEN
LOG3="$LOGPATH/$TOKEN""curl3.log"
echo "LOG3 = "$LOG3
TIMESTAMP=$(date +%s)
echo $TIMESTAMP

# Get Hive/US-Dollar value
curl -H "X-CMC_PRO_API_KEY: a1ff4bd0-2ac9-4700-ae61-6eaa62f56adc" -H "Accept: application/json" -d "symbol=HIVE" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/info > $CMC 




# ---- calculating Hiveprice ----
HIVEPRICE=`cat $CMC  | awk -F'price of Hive is' '{print $2}' | awk -F'USD ' '{print $1}'`
echo "The price of \$USD/\$HIVE = "$HIVEPRICE 
TOKENPRICELIST=`cat $LOG3 | awk -F'price\":\"' '{print $2}' | awk -F'\"' '{print $1}'`
TOKENPRICE=`echo $TOKENPRICELIST | awk -F ' ' '{print $NF}'`
echo "The price of \$HIVE/$TOKEN = " $TOKENPRICE
DOLLAR_TOKEN=`echo "scale=6; x=$TOKENPRICE*$HIVEPRICE; if(x<1) print 0;x/1"|bc`
echo "The price of \$USD/\$TOKEN = "$DOLLAR_TOKEN

echo "{\"index\": {\"_index\":\"dollartoken\"}} 
{\"token\":\"$TOKEN\",\"timestamp\":$TIMESTAMP,\"usd_hive\":$HIVEPRICE,\"hive_token\":$TOKENPRICE,\"usd_token\":$DOLLAR_TOKEN}" >> $DOLLARTOKEN
# The result shold have this format:
# {"token":$TOKEN,"timestamp":1631274978,"usd_hive":"0.75","hive_token":"0.005","usd_token":"0.0037"}"
#


# Upload the Result to kibana:
curl --location --request POST 'http://localhost:9200/dollartoken/_bulk?' --header 'Content-Type: application/json' --data-binary @$DOLLARTOKEN






