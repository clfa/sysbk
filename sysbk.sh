#!/bin/bash

sp="/mnt/example"

#mount dev to save backup files
mount /dev/example $sp >/dev/null 2>&1

#change directory of dev
topath="$sp/example"
cd $topath
path=`pwd`
if [[ $path = $topath ]]
then
    ti=`date "+%Y%m%d%H%M"`
    echo "Start time: $ti"
    na="$ti""sysbk.tgz"
    #echo $na
    log="$ti""sysbk.log"
    #backup operation
    homewk="/home/example"
    tar cvPzf $na / --exclude=/dev --exclude=/lost+found --exclude=/media --exclude=/mnt --exclude=/proc --exclude=/sbin --exclude=/sys --exclude=/tmp --exclude=/var --exclude=$homewk/Documents --exclude=$homewk/Downloads --exclude=$homewk/Music --exclude=$homewk/Pictures --exclude=$homewk/Videos --exclude=$homewk/Work --exclude=/home/lost+found --exclude=/run > $log

    endtime=`date "+%Y%m%d%H%M"`
    echo "End time: $endtime"
    ret=`echo $?`
    if [[ $ret = "1" ]]
    then
        echo "Have errors, please check the log file!"
    fi
else
    echo "Can not go to directory <$topath> !"
fi
