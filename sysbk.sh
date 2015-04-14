#!/bin/bash
# The script aids to backup system and important configure files. 
# Author:clf 
# Email: safeskycn@gmail.com
# Time: 2015-04-14

home="example"
bkdir1="example"
bkdir2="example"


if [ -e $bkdir1 ]; then
    cd $bkdir1
elif [ -e $bkdir2 ]; then
    cd $bkdir2
elif [ -e $homebk ]; then
    cd $homebk
else 
    echo "The disk has no free space to backup." | /usr/bin/mail -s "Backup-Failed" root
    exit 1
fi

# for test
echo $(pwd)

ti=`date "+%F"`
na="$(uname -r)""-${ti}-system-bak.tar.bz2"
echo $na
log="$(uname -r)""-${ti}.log"
echo "Start time: $(date +%Y-%m-%d-%H:%M:%S)" >> $log 

#Backup system
tar -jcpP -f $na / --exclude=/dev --exclude=/media --exclude=/mnt --exclude=/proc --exclude=/sbin --exclude=/sys --exclude=/tmp --exclude=/var --exclude=$home/Documents --exclude=$home/Downloads --exclude=$home/Music --exclude=$home/Pictures --exclude=$home/Videos --exclude=$home/Work --exclude=/run --exclude=$home --exclude=$home/$na 2>>$log
ret1=`echo $?`
#Backup user configure files
tar -jcpP -f  "$(uname -r)""-${ti}-config-bak.tar.bz2" /root /etc ${home}/.vim* ${home}/.bash* ${home}/.emacs* ${home}/.zshrc 2>>$log
ret2=`echo $?`

echo "End time: $(date +%Y-%m-%d-%H:%M:%S)" >>$log
if [ "$ret1"x != "0"x ] || [ "$ret2"x != "0"x ]; then
    echo "Errors occurred. Please check the log file ${log}." >> $log
    exit 2
else
    echo "Backup successfully." >> $log
    exit 0
fi
