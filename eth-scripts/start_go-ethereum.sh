#!/bin/bash
#
# Start go-ethereum with Netstat
#
# Logging verbosity: 
# 0-6 (0=silent, 1=error, 2=warn, 3=info, 4=core, 5=debug, 6=debug detail)
#

ETHGOPATH="$HOME"
ETHDATADIR="$HOME"

export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_HEAP_SIZE=100

LOGPATH=/tmp
mkdir -p $LOGPATH

LOG=$LOGPATH/geth.log

# start go-ethereum
if [ ! $(pgrep geth) ]; then
  nohup $ETHGOPATH/go-ethereum/build/bin/geth --datadir "$ETHDATADIR/.ethereum" --rpc --maxpeers "15" \
  --verbosity "3" --support-dao-fork > $LOG 2>&1 &
fi

sleep 5

# print pid
pid=$(pgrep geth)
if [ $? -eq 0 ]; then
  echo "ethereum start/running, $pid"
fi

exit 0
