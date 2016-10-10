#!/bin/bash

# stop go-ethereum
#echo $(ps ax | grep 'go-ethereum' | grep 'grep' -v | awk '{print $1}') > /tmp/ethereum.pid 
#ethereumpid=$(cat /tmp/ethereum.pid)
#if [ "$ethereumpid" > 0 ]; then
#   $(kill $ethereumpid)
#   echo "Ethereum stopped"
#fi
#rm /tmp/ethereum.pid

if [ $(pgrep geth) ]; then
   pkill geth
fi

sleep 5

if [ ! $(pgrep geth) ]; then
   echo "ethereum stop/waiting"
fi

exit 0
