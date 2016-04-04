#!/bin/bash
#
# install eth-net-intelligence-api
#

if [[ -d "$HOME/eth-net-intelligence-api" ]]; then
    	echo "remove $HOME/eth-net-intelligence-api before install" 
    	exit 1
else
	cd $HOME
	git clone https://github.com/cubedro/eth-net-intelligence-api.git
	cd  eth-net-intelligence-api
	npm install
	exit 0
fi
