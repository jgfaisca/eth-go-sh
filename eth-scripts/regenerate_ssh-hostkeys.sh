#!/bin/bash
#
# Regenerating SSH host keys
#

sudo rm /etc/ssh/ssh_host_rsa_key*
sudo rm /etc/ssh/ssh_host_dsa_key*
sudo ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
sudo ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

exit 0
