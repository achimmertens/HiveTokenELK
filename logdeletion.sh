# !/bin/bash
#
# Beispiel alte Logfiles löschen, die älter als 5 Tage sind: 
# find /appl/log -name "*.log" -type f -mtime +5 -exec rm {} \;
# sollte die Platte so voll sein, dass nichts mehr geht, kann man eine große Datei mit "nichts" überschreiben. Beispiel: 
# cat > iDome_2011-03-05_185.log
# Siehe auch: 
# du -sm ./* | sort -n
# du -sh ./* |sort -n
# oder noch schöner: 
# arrayname=(`ls -l | grep ^d| awk '{ print $9 }' `)
# echo "${arrayname[@]}"
# for i in "${arrayname[@]}"
# do
# (du -hs $i)
# done

# Finde alle Dateien, die älter sind als 10 Tage und Lösche sie.
LOGPATH="/home/pi/elk/chary/log"
echo "LOGPATH = "$LOGPATH
find $LOGPATH -name "*.log" -type f -mtime +10 -exec rm {} \;
