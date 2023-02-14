echo "Upload the complete json data into kibana:
This can be done, when elasticsearch was down, but cronjobs were running.
So the data was collected to xxxcurlcons.log"

ELKPATH="/home/pi/elk/"
TOKEN="alive"
URL="http://localhost:9200/$TOKEN/_bulk?"

#    Beerbot
echo "Uploading Beerbot-data..."
curl --location --request POST 'http://localhost:9200/beerbot/_bulk?' --header 'Content-Type: application/json' --data-binary @$ELKPATH"beer/logbot/beerbotcurlcons.log"

# All other coins:
for TOKEN in "alive" "list" "chary" "luv" "lolz" "pob" "beer" "leo" "sim" "spt"
do
echo
echo
echo "------------------------------------- Next Token: $TOKEN  --------------------------"
echo
URL="http://localhost:9200/"$TOKEN"/_bulk?";
echo "The URL is: "$URL;
# DATA=$ELKPATH$TOKEN"/log/"$TOKEN"curlcons.log";
DATA=$ELKPATH$TOKEN"/log/dollartoken.json";
echo "The data file is: "$DATA;
curl --location --request POST $URL --header 'Content-Type: application/json' --data-binary @$DATA;
done

# Taken from crontab:
#49 4 * * Sat date > /var/www/html/elk/index.html 2>>/home/pi/elk/index_cron.log
#48 4 * * * /home/pi/elk/alive/alivecurl_json.sh >> /home/pi/elk/alive/log/cron.log
#49 4 * * * /home/pi/elk/lolz/lolzcurl_json.sh >> /home/pi/elk/lolz/log/cron.log
#50 4 * * * /home/pi/elk/luv/luvcurl_json.sh >> /home/pi/elk/luv/log/cron.log
#51 4 * * * /home/pi/elk/beer/beercurl_json.sh >> /home/pi/elk/beer/log/cron.log
#52 4 * * * /home/pi/elk/chary/charycurl_json.sh >> /home/pi/elk/chary/log/cron.log
#53 4 * * * /home/pi/elk/pob/pobcurl_json.sh >> /home/pi/elk/pob/log/cron.log
#54 4 * * * /home/pi/elk/list/listcurl_json.sh >> /home/pi/elk/list/log/cron.log
#55 4 * * * /home/pi/elk/leo/leocurl_json.sh >> /home/pi/elk/leo/log/cron.log
#56 4 * * * /home/pi/elk/sim/simcurl_json.sh >> /home/pi/elk/sim/log/cron.log
#57 4 * * * /home/pi/elk/beer/botcurl_json.sh >> /home/pi/elk/beer/logbot/cron.log
#58 4 * * * /home/pi/elk/spt/sptcurl_json.sh >> /home/pi/elk/spt/log/cron.log
#05 5 * * * /home/pi/elk/chary/dollarchary.sh >> /home/pi/elk/chary/log/cron.log
#06 5 * * * /home/pi/elk/beer/dollarbeer.sh >> /home/pi/elk/beer/log/cron.log
#07 5 * * * /home/pi/elk/leo/dollarleo.sh >> /home/pi/elk/leo/log/cron.log
#08 5 * * * /home/pi/elk/list/dollarlist.sh >> /home/pi/elk/list/log/cron.log
#09 5 * * * /home/pi/elk/pob/dollarpob.sh >> /home/pi/elk/pob/log/cron.log
#10 5 * * * /home/pi/elk/sim/dollarsim.sh >> /home/pi/elk/sim/log/cron.log
#11 5 * * * /home/pi/elk/spt/dollarspt.sh >> /home/pi/elk/spt/log/cron.log
#12 5 * * * /home/pi/elk/luv/dollarluv.sh >> /home/pi/elk/luv/log/cron.log
#13 5 * * * /home/pi/elk/lolz/dollarlolz.sh >> /home/pi/elk/lolz/log/cron.log
#14 5 * * * /home/pi/elk/alive/dollaralive.sh >> /home/pi/elk/alive/log/cron.logTH
