#!/bin/bash

cd $HOME/go-ethereum
git pull
export GO_OPENCL=true
export GPU_MAX_ALLOC_PERCENT=95
make geth

