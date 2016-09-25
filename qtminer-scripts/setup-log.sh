#!/bin/bash
#
# initial setup
#

CONF="/etc/logrotate.d/qtminer"
[ -f ./logstatus ] && rm ./logstatus 
# copy configuration
sudo cp ./logrotate.conf $CONF
# configuration status
logrotate -s ./logstatus $CONF
# print status
cat logstatus

