#!/bin/bash
#
# Start go-ethereum with Netstat
#
# Logging verbosity: 
# 0-6 (0=silent, 1=error, 2=warn, 3=info, 4=core, 5=debug, 6=debug detail)
#

LOGPATH=./
mkdir -p $LOGPATH/log

LOG=$LOGPATH/geth.log
ERR=$LOGPATH/geth.err

# start  Netstat
cd $ETHNETPATH/eth-net-intelligence-api
pm2 start $ETHNETPATH/eth-net-intelligence-api/app.json
echo "PM2 started"

# start go-ethereum
nohup $ETHGOPATH/go-ethereum/build/bin/geth --datadir "$ETHDATADIR" --rpc --maxpeers "25" \
--verbosity "2" >$LOG 2>$ERR &

echo "Ethereum started"

exit 0
