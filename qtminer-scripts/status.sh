#!/bin/bash
#
# qtminer process status
#

pgrep qtminer >/dev/null 2>&1

if [ $? -eq 0 ]; then
        PID=$(ps aux --sort pid | grep -w "qtminer.sh" | awk 'NR==1 {print $2}') 
        echo "qtminer start/running, $PID"
        exit 0
else
        echo "qtminer stop/waiting"
        exit 1
fi

