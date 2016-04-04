#!/bin/bash
#
# Reset Host 
#
#

read -p "Remove $ETHGOPATH/go-ethereum? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  rm -rfv $ETHEREUM_DIR/go-ethereum
else
  echo "No"
fi

read -p "Remove $ETHNETPATH/eth-net-intelligence-api? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  rm -rfv $ETHEREUM_DIR/eth-net-intelligence-api
else
  echo "No"
fi

read -p "Remove $ETHDATADIR/.ethereum? (y/n) " RESP
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

exit 0

