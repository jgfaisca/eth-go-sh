#!/bin/bash

cd $HOME/go-ethereum
git pull
export GO_OPENCL=true
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100
make geth
$HOME/eth-scripts/restart_go-ethereum.sh

exit 0

