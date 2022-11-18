#!/bin/bash

# taken from: https://iq.opengenus.org/automated-backup-in-linux-using-shell-scripting-and-crontab-scheduler/

#Specify folders whose backup is to be taken in variables
f1="/home/pi/elk"
# f2="/home/nishkarshraj/Desktop/Computer-Graphics"
# f3="/home/nishkarshraj/Desktop/HelloWorld"

filename="backup_`date +%d`_`date +%m`_`date +%Y`.tar.gz";
backupfolder="/media/pi/Elements/raspibackup";


#tar = Tape Archive tool for compression
#Creating same backup tar file for all specified folders
echo "The created file will be: "$backupfolder/$filename
cd $f1
tar -cvzf $backupfolder/$filename . #$f2 $f3


#Show the size of the folder
du -sh $backupfolder

# Read content of tar file example:
# tar -tf backup_11_11_2022.tar

# extract complete tar file example:
# tar -xvzf backup_11_11_2022.tar
# tar -xvzf backup_11_11_2022.tar -C /home/user/files #choose target folder

# extract only one file example:
# tar -xf filename.tar.gz file1 directory1
# tar -xf backup_11_11_2022.tar.gz home/pi/elk/chary/charyviews.ndjson

# Delete Files older than 8 days:
find $backupfolder -type f -mtime +8 -exec rm {} \;


