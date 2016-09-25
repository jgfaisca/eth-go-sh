#!/bin/bash

QTMINER_DIR=$HOME/qtminer
LOGFILE="/tmp/qtminer.log"
PIDFILE="/tmp/qtminer.pid"

# reset variables
function reset_vars(){
 [ -f $LOGFILE ] || touch $LOGFILE
}

reset_vars

#nohup $QTMINER_DIR/mine.sh > $LOGFILE 2>&1 &
nohup $QTMINER_DIR/mine.sh > /dev/null 2>&1 & # doesn't create log

pgrep qtminer >/dev/null 2>&1

if [ $? -eq 0 ]; then
	PID=$(ps aux --sort pid | grep -w "qtminer.sh" | awk 'NR==1 {print $2}')
	echo "qtminer start/running, $PID"
	echo $PID >> $PIDFILE
        exit 0
else
	echo "qtminer stop/waiting"
        exit 1
fi

