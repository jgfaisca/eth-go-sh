#!/bin/bash
#
# stop qtminer
#

PIDFILE="/tmp/qtminer.pid"
CMD="pkill -f qtminer"
echo "$CMD"
eval "$CMD"
[ -f $PIDFILE ] && rm $PIDFILE
