#!/bin/bash

# install go-ethereum

if [[ -d "$ETHGOPATH/go-ethereum" ]]; then
    echo "remove $ETHGOPATH/go-ethereum before install"
    exit 1 
else
	cd $ETHGOPATH
	git clone https://github.com/ethereum/go-ethereum.git
	cd go-ethereum
	export GO_OPENCL=true
        export GPU_MAX_ALLOC_PERCENT=100
        export GPU_SINGLE_ALLOC_PERCENT=100
	make geth
	exit 0
fi




