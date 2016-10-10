#!/bin/bash
#
# status
#


pid=$(pgrep geth)

if [ $? -eq 0 ]; then
   echo "ethereum start/running, $pid"
else
   echo "ethereum stop/waiting"
fi

exit 0
