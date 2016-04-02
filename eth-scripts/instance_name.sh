#!/bin/bash
#
# print instance name
#

H="eth"
H0=$(ssh-keygen -l -f /etc/ssh/ssh_host_rsa_key.pub)
H1=$(echo $H0 $(uname -snmpio) | md5sum)
H2="${H1:0:13}"
H3="$H$H2"

echo "$H3"

