#!/bin/bash
#
# Install Ethereum Mist on debian/ubuntu
#

MISTPATH=$HOME

# git
sudo apt-get install -y git

# nodejs
node --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
  	echo "node is not being recognized as a command; installing ...";
  	(exec "./install_nodejs.sh")
fi

# meteor
curl https://install.meteor.com/ | sh
sudo npm install -g meteor-build-client

# electron
sudo npm install -g electron-prebuilt@1.2.2

# gulp
sudo npm install -g gulp

# mist + wallet
cd $MISTPATH
git clone https://github.com/ethereum/mist.git
cd mist
git submodule update --init
npm install
# walletSource options: master, develop, local
# platform options: darwin, win32, linux, all
gulp mist --walletSource develop --platform "linux" 
gulp mist-checksums
gulp wallet --walletSource develop --platform "linux" 
gulp wallet-checksums
cd ..
