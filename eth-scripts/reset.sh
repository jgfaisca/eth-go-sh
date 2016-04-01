#!/bin/bash

# Reset Host 

ETHEREUM_DIR=$HOME

read -p "Remove $ETHEREUM_DIR/go-ethereum? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  rm -rfv $ETHEREUM_DIR/go-ethereum
else
  echo "No"
fi

read -p "Remove $ETHEREUM_DIR/eth-net-intelligence-api? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  rm -rfv $ETHEREUM_DIR/eth-net-intelligence-api
else
  echo "No"
fi

read -p "Remove $ETHEREUM_DIR/.ethereum? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  rm -rIv $ETHEREUM_DIR/.ethereum
else
  echo "No"
fi

read -p "Regenerate Host Keys? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  (exec "./regenerate_ssh-hostkeys.sh")
else
  echo "No"
fi


