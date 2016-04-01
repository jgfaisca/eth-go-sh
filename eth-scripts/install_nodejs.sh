#!/bin/bash

#
# Description: 	Install nodejs (>= 4) via package manager
#
# Author:	Jose G. Faisca <jose.faisca@gmail.com>
#
#

# version
VERSION="5"

if ! curl --version &> /dev/null ; then
  echo "curl is not being recognized as a command; installing...";
  sudo apt-get -y install curl
fi

curl -sL https://deb.nodesource.com/setup_$VERSION.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
