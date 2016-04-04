#!/bin/bash
#
# Start go-ethereum with Netstat
#

LOG=$ETHNETPATH/ethereum.log
ERR=$ETHNETPATH/ethereum.err

# start  Netstat
cd $ETHNETPATH/eth-net-intelligence-api
pm2 start  $ETHNETPATH/eth-net-intelligence-api/app.json
echo "PM2 started"

# start go-ethereum
nohup $ETHGOPATH/go-ethereum/build/bin/geth --datadir=$ETHDATADIR --rpc --maxpeers "25" \
--verbosity "0" >$LOG 2>$ERR &

echo "Ethereum started"

exit 0
