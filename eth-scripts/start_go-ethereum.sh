#!/bin/bash

ETHEREUM_DIR=$HOME

# start  Netstat
cd $ETHEREUM_DIR/eth-net-intelligence-api
pm2 start  $ETHEREUM_DIR/eth-net-intelligence-api/app.json
echo "PM2 started"

# start go-ethereum
nohup $ETHEREUM_DIR/go-ethereum/build/bin/geth --rpc --maxpeers "25" --verbosity "0" \
>$ETHEREUM_DIR/ethereum.log 2>$ETHEREUM_DIR/ethereum.err &

echo "Ethereum started"


