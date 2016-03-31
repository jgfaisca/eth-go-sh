#!/bin/bash

# update eth-net-intelligence-api

if [[ -d "$HOME/eth-net-intelligence-api" ]]; then
	 tmpfile=$(mktemp /tmp/app.json.XXXXXX)
     cd $HOME/eth-net-intelligence-api
     cp app.json $tmpfile
     git reset --hard
     git pull
     cp $tmpfile ./
     rm $tmpfile
else
     echo "$HOME/eth-net-intelligence-api not found" 
fi

exit 0


