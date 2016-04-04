#!/bin/bash
#
# Update Netstat
#

if [[ -d "$ETHNETPATH/eth-net-intelligence-api" ]]; then
	tmpfile=$(mktemp /tmp/app.json.XXXXXX)
     	cd $ETHNETPATH/eth-net-intelligence-api
     	cp app.json $tmpfile
     	git reset --hard
     	git pull
	sudo npm update
     	cp $tmpfile ./app.json
     	rm $tmpfile
     	pm2 gracefulReload node-app
else
     	echo "$ETHNETPATH/eth-net-intelligence-api not found"
     	exit 1
fi

exit 0


