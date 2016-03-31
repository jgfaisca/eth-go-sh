#!/bin/bash

# stop Netstat
echo $(ps ax | grep 'PM2' | grep 'grep' -v | awk '{print $1}') > /tmp/netstat.pid 
netstatpid=$(cat /tmp/netstat.pid)

if [ "$netstatpid" > 0 ]; then
   $(kill $netstatpid)
   echo "PM2 stopped"
fi
rm /tmp/netstat.pid


# stop go-ethereum
echo $(ps ax | grep 'go-ethereum' | grep 'grep' -v | awk '{print $1}') > /tmp/ethereum.pid 
ethereumpid=$(cat /tmp/ethereum.pid)

if [ "$ethereumpid" > 0 ]; then
   $(kill $ethereumpid)
   echo "Ethereum stopped"
fi

rm /tmp/ethereum.pid


