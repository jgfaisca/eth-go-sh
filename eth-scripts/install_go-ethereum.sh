#!/bin/bash

# install go-ethereum

if [[ -d "$HOME/go-ethereum" ]]; then
    echo "remove $HOME/go-ethereum before install"
    exit 1 
else
	cd $HOME
	git clone https://github.com/ethereum/go-ethereum.git
	cd go-ethereum
	export GO_OPENCL=true
        export GPU_MAX_ALLOC_PERCENT=100
        export GPU_SINGLE_ALLOC_PERCENT=100
	make geth
	exit 0
fi




