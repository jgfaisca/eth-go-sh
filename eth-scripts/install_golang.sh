#!/bin/bash

#
# Description: 	Install the Go programming language (>= 1.2.2)
#
# Author:	Jose G. Faisca <jose.faisca@gmail.com>
#
# Add /usr/local/go/bin to the PATH environment variable. 
# You can do this by adding this line to your /etc/profile 
# (for a system-wide installation) or $HOME/.profile:
#
# export PATH=$PATH:/usr/local/go/bin
#

# system architecture
ARCH="amd64"
# OS
OS="linux"
# go repository
REPO="https://storage.googleapis.com/golang"
# installation path
INSTALL_PATH="/usr/local/"
# go version
VERSION="1.6"
# tar file
TAR_FILE="go$VERSION.$OS-$ARCH.tar.gz"
# URL
URL="$REPO/$TAR_FILE"

if ! curl --version &> /dev/null ; then
  echo "curl is not being recognized as a command; installing... ";
  sudo apt-get install -y curl
fi

# download
curl -O "$URL"

# uncompress to installation path
CMD="sudo tar -C $INSTALL_PATH -xvzf $TAR_FILE"
echo $CMD
eval $CMD && rm -f $TAR_FILE

mkdir -p $HOME/go
mkdir -p $HOME/work

cp resources/bash_profile $HOME/.bash_profile &&
eval $HOME/.bash_profile

go version
