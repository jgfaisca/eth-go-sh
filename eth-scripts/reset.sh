#!/bin/bash
#
# Reset Host 
#
#

read -p "Remove $ETHGOPATH/go-ethereum? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  rm -rfv $ETHGOPATH/go-ethereum
else
  echo "No"
fi

read -p "Remove $ETHNETPATH/eth-net-intelligence-api? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  rm -rfv $ETHNETPATH/eth-net-intelligence-api
else
  echo "No"
fi

read -p "Remove $ETHDATADIR/.ethereum? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  rm -rIv $ETHDATADIR/.ethereum
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

