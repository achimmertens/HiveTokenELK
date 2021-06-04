# hello world
# curl -H "X-CMC_PRO_API_KEY: a1ff4bd0-2ac9-4700-ae61-6eaa62f56adc" -H "Accept: application/json" -d "symbol=HIVE" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/info > coinmarketcap.tmp
cat coinmarketcap.tmp  | awk -F'price of Hive is' '{print $2}' | awk -F'USD ' '{print $1}' > hiveprice.tmp
HIVEPRICE=$(cat hiveprice.tmp)
echo "HIVEPRICE = "$HIVEPRICE
NEWPRICE=`echo $HIVEPRICE \* 2|bc`
echo "NEWPRICE = "$NEWPRICE 
