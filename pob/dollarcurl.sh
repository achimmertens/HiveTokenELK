curl -H "X-CMC_PRO_API_KEY: a1ff4bd0-2ac9-4700-ae61-6eaa62f56adc" -H "Accept: application/json" -d "symbol=HIVE" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/info > coinmarketcap.tmp
HIVEPRICE=`cat coinmarketcap.tmp  | awk -F'price of Hive is' '{print $2}' | awk -F'USD ' '{print $1}'`
echo "The price of \$HIVE/\$USD = "$HIVEPRICE
echo "The price of \$HIVE/\$USD = "$HIVEPRICE > pobdollar.tmp
POBPRICELIST=`cat pobcurl3.log | awk -F'price\":\"' '{print $2}' | awk -F'\"' '{print $1}'`
POBPRICE=`echo $POBPRICELIST | awk -F ' ' '{print $NF}'`
echo "The price of \$POB/\$HIVE = " $POBPRICE
echo ". The price of \$POB/\$HIVE = " $POBPRICE >> pobdollar.tmp
POBDOLLAR=`echo $POBPRICE \* $HIVEPRICE|bc`
echo "The price of \$POB/\$USD = "$POBDOLLAR
echo ". The price of \$POB/\$USD = "$POBDOLLAR >> pobdollar.tmp
sudo cp pobdollar.tmp /var/www/html/elk/index.html
