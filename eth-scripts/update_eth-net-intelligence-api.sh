#!/bin/bash

# update eth-net-intelligence-api

if [[ -d "$HOME/eth-net-intelligence-api" ]]; then
	pm2 stop node-app &&
	tmpfile=$(mktemp /tmp/app.json.XXXXXX)
     	cd $HOME/eth-net-intelligence-api
     	cp app.json $tmpfile
     	git reset --hard
     	git pull
	sudo npm update
     	cp $tmpfile ./app.json
     	rm $tmpfile
     	pm2 gracefulReload node-app
else
     	echo "$HOME/eth-net-intelligence-api not found" 
fi

exit 0


