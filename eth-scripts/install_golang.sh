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
VERSION="1.10"

if [ $# -eq 1 ]; then
   VERSION=$1
fi

# tar file
TAR_FILE="go$VERSION.$OS-$ARCH.tar.gz"
# URL
URL="$REPO/$TAR_FILE"

echo "Installing golang version $VERSION ..."

# install curl
curl --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "curl is not being recognized as a command; installing... ";
  sudo apt-get install -y curl
fi

# download go
curl -O "$URL"

# remove previous extracted files
[ -d "$INSTALL_PATH/go" ] && sudo rm -rf $INSTALL_PATH/go

# uncompress to installation path
CMD="sudo tar -C $INSTALL_PATH -xvzf $TAR_FILE"
echo $CMD
eval $CMD && rm -f $TAR_FILE

# create dirs
mkdir -p $HOME/go
mkdir -p $HOME/work

# copy profile
cp resources/bash_profile $HOME/.bash_profile &&
echo "source \$HOME/.bash_profile" >> $HOME/.profile &&
source $HOME/.bash_profile

# output version
go version

exit 0
