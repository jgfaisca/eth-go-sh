#!/bin/bash
#
# Update go-ethereum
#

cd $ETHGOPATH/go-ethereum
git pull
export GO_OPENCL=true
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100
make geth
sudo service ethereum restart

exit 0

