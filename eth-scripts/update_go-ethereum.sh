#!/bin/bash
#
# update go-ethereum
#

cd $HOME/go-ethereum
git pull
export GO_OPENCL=true
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100
make geth
$HOME/eth-scripts/stop_go-ethereum.sh
$HOME/eth-scripts/start_go-ethereum.sh

exit 0

