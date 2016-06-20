#!/bin/bash
cat <<EOF | geth attach | sed -n -r  's/^([0-9\.]+)$/\1/p'
web3.fromWei(eth.getBalance(eth.coinbase), "ether")
exit
EOF
