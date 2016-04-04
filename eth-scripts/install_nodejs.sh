#!/bin/bash
#
# Description: 	Install nodejs (>= 4) via package manager
#
# Author:	Jose G. Faisca <jose.faisca@gmail.com>
#
#

# nodejs version
VERSION="5"

# install curl
curl --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "curl is not being recognized as a command; installing... ";
  sudo apt-get install -y curl
fi

# install node
curl -sL https://deb.nodesource.com/setup_$VERSION.x | sudo -E bash -
sudo apt-get install -y nodejs

# install build-essential
sudo apt-get install -y build-essential

# output version
echo "node version = $(node --version)"
echo "npm version = $(npm --version)"

exit 0
