#!/bin/bash
#
# install eth-net-intelligence-api
#

if [[ -d "$ETHNETPATH/eth-net-intelligence-api" ]]; then
    	echo "remove $ETHNETPATH before install" 
    	exit 1
else
	cd $ETHNETPATH
	git clone https://github.com/cubedro/eth-net-intelligence-api.git
	cd  eth-net-intelligence-api
	npm install
	exit 0
fi
