echo "If the cronjobs didnt run in the morning, we can do it now with this script"


# Taken from crontab:
date > /var/www/html/elk/index.html 2>>/home/pi/elk/index_cron.log
/home/pi/elk/alive/alivecurl_json.sh >> /home/pi/elk/alive/log/cron.log
/home/pi/elk/lolz/lolzcurl_json.sh >> /home/pi/elk/lolz/log/cron.log
/home/pi/elk/luv/luvcurl_json.sh >> /home/pi/elk/luv/log/cron.log
/home/pi/elk/beer/beercurl_json.sh >> /home/pi/elk/beer/log/cron.log
/home/pi/elk/chary/charycurl_json.sh >> /home/pi/elk/chary/log/cron.log
/home/pi/elk/pob/pobcurl_json.sh >> /home/pi/elk/pob/log/cron.log
/home/pi/elk/list/listcurl_json.sh >> /home/pi/elk/list/log/cron.log
/home/pi/elk/leo/leocurl_json.sh >> /home/pi/elk/leo/log/cron.log
/home/pi/elk/sim/simcurl_json.sh >> /home/pi/elk/sim/log/cron.log
/home/pi/elk/beer/botcurl_json.sh >> /home/pi/elk/beer/logbot/cron.log
/home/pi/elk/spt/sptcurl_json.sh >> /home/pi/elk/spt/log/cron.log
/home/pi/elk/chary/dollarchary.sh >> /home/pi/elk/chary/log/cron.log
/home/pi/elk/beer/dollarbeer.sh >> /home/pi/elk/beer/log/cron.log
/home/pi/elk/leo/dollarleo.sh >> /home/pi/elk/leo/log/cron.log
/home/pi/elk/list/dollarlist.sh >> /home/pi/elk/list/log/cron.log
/home/pi/elk/pob/dollarpob.sh >> /home/pi/elk/pob/log/cron.log
/home/pi/elk/sim/dollarsim.sh >> /home/pi/elk/sim/log/cron.log
/home/pi/elk/spt/dollarspt.sh >> /home/pi/elk/spt/log/cron.log
/home/pi/elk/luv/dollarluv.sh >> /home/pi/elk/luv/log/cron.log
/home/pi/elk/lolz/dollarlolz.sh >> /home/pi/elk/lolz/log/cron.log
/home/pi/elk/alive/dollaralive.sh >> /home/pi/elk/alive/log/cron.log

