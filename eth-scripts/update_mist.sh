#!/bin/bash
#
# Update Ethereum Mist on debian/ubuntu
#

MISTPATH=$HOME

cd $MISTPATH
cd mist
git pull && git submodule update
if [ $? -ne 0 ]; then
    npm install 
    # walletSource options: master, develop, local
    # platform options: darwin, win32, linux, all
    gulp mist --walletSource develop --platform "linux" 
    gulp mist-checksums
    gulp wallet --walletSource develop --platform "linux" 
    gulp wallet-checksums
fi
cd ..
