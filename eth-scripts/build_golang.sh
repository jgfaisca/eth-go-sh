#!/bin/bash

#
# Description: 	Build and install the Go programming language (>= 1.5)
#
# Author:	Jose G. Faisca <jose.faisca@gmail.com>
#

# When run as (for example)
#
#	--release go1.5.1 --build --install --tools --tests
#
# this script will use $GOROOT_BOOTSTRAP to bootstrap a local build.
# Will build Go, execute tests and install Go + tools to $INTALL_PATH
#
# In order to update to a new release run as (for example)
#
#	--release go.1.5.2 --update --install --tools --tests
#

# system architecture
ARCH=""
# go repository
REPO="https://go.googlesource.com/go"
# installation path
INSTALL_PATH="/usr/local/"
# go release
RELEASE="0"
# arguments
BUILD=1;UPDATE=1;INSTALL=1;TESTS=1;ADDTOOLS=1
# uncompressed tar directory
TARDIR=""

#------ GO environment variables --------
#
# the root of the Go tree
GOROOT="$HOME/go"
# bootstrap directory
BOOTSTRAP_DIR=""
# workspace path
WORKPATH="$HOME/goworkspace"
#
#-----------------------------------------

# uncompress tar file
function uncompress_tar() {
  FILE="$1"
  EXTENSION="${FILE##*.}"
  DEST="$2"
  if [[ "$EXTENSION" == "tar" ]]; then
    tar xvf $FILE -C "$DEST"
  elif [[ "$EXTENSION" == "gz" ]] || [[ "$EXTENSION" == "tgz" ]]; then
    tar xzvf $FILE -C "$DEST"
  elif [[ "$EXTENSION" == "bz2" ]] || [[ "$EXTENSION" == "tbz" ]]; then
    tar xjvf $FILE -C "$DEST"
  else
    echo "Invalid tar file $FILE"
    exit 1
  fi
}

# setup bootstrap directory
function setup_bootstrap() { 
  get_arch
  if [[ "$OSTYPE" == "linux-"* ]] && [[ "$ARCH" == "armv5"* ]]; then
    	# Unofficial url to go 1.4.2 binary (Linux armv5)
        URL="http://dave.cheney.net/paste/go1.4.2.linux-arm~armv5-1.tar.gz"
  elif [[ "$OSTYPE" == "linux-"* ]] && [[ "$ARCH" == "armv6"* ]]; then
        # Unofficial url to go 1.4.2 binary (Linux armv6)
        URL="http://dave.cheney.net/paste/go1.4.2.linux-arm~multiarch-armv6-1.tar.gz"
  elif [[ "$OSTYPE" == "linux-"* ]] && [[ "$ARCH" == "armv7"* ]]; then
        # Unofficial url to go 1.4.2 binary (Linux armv7)
        URL="http://dave.cheney.net/paste/go1.4.2.linux-arm~multiarch-armv7-1.tar.gz"
  elif [[ "$OSTYPE" == "linux-"* ]] && [[ "$ARCH" == "i686" ]]; then
		# official url to go 1.4.3 binary (Linux 32-bit)
        URL="https://storage.googleapis.com/golang/go1.4.3.linux-386.tar.gz"
  elif [[ "$OSTYPE" == "linux-"* ]] && [[ "$ARCH" == "x86_64" ]]; then
        # official url to go 1.4.3 binary (Linux 64-bit)
        URL="https://storage.googleapis.com/golang/go1.4.3.linux-amd64.tar.gz"
  elif [[ "$OSTYPE" == "darwin"* ]] && [[ "$ARCH" == "x86_64" ]]; then
    	# official url to go 1.4.3 binary (MacOSX 64-bit)
    	URL="https://storage.googleapis.com/golang/go1.4.3.darwin-amd64.tar.gz"
  else
	echo "$OSTYPE $ARCH is not supported"
	exit 1
  fi

  # uncompress tar destination dir
  BOOTSTRAP_DIR="$HOME/go-$ARCH-$OSTYPE-bootstrap"

  # compressed binary
  BIN="${URL##*/}"

  [ ! -d $BOOTSTRAP_DIR ] && mkdir -p "$BOOTSTRAP_DIR"

  [ ! -f $BIN ] && curl -O "$URL"

  uncompress_tar "$BIN" "$BOOTSTRAP_DIR"
  BOOTSTRAP_DIR="$BOOTSTRAP_DIR/go"
}

function show_help() {
   echo "$(basename $0) is a tool to build and install Go"
   echo
   echo "Usage:"
   echo
   echo	"	./$(basename $0) [-r|--release] <gorelease> [arguments]"
   echo
   echo "The <gorelease> is the	version string of the release (>= go1.5)"
   echo
   echo "The arguments are:"
   echo
   echo " 	-b|--build	build the Go distribution"
   echo "	-u|--update	keeping up the release"
   echo "	-i|--install	install Go to $INSTALL_PATH"
   echo "	-a|--addtools 	install additional tools"
   echo "	-t|--tests	runs important tests for Go,"
   echo	"			which can take more time than simply"
   echo	"			building Go"
   echo
   exit 0
}

function get_arch() {
 ARCH=$(uname -m)
 if [ -z "$ARCH" ]; then
    echo "Invalid system architecture." 
    exit 1
 fi
}

# fetch the repository
function fetch_repo() {
 CMD="git clone $REPO"
 if ! eval "$CMD"; then
   echo "Error fetching repository $REPO"
   exit 1
 fi
}

# build Go
function build_go() {
   export GOROOT_BOOTSTRAP=$BOOTSTRAP_DIR
   cd "$GOROOT"
   git checkout "$RELEASE"
   cd src
   if [[ "$TESTS" == "0" ]]; then
        ulimit -s 1024
        ulimit -s
        export GO_TEST_TIMEOUT_SCALE=10
	./all.bash
   else
 	./make.bash
   fi
}

# update Go
function update_go() {
   export GOROOT_BOOTSTRAP=$BOOTSTRAP_DIR
   cd "$GOROOT/src"
   git fetch
   git checkout "$RELEASE"
      if [[ "$TESTS" == "0" ]]; then
        ulimit -s 1024
        ulimit -s
        export GO_TEST_TIMEOUT_SCALE=30
        ./all.bash
   else
        ./make.bash
   fi
}

# end message
function end_msg() {
	echo
        echo "To get started create a workspace directory (e.g. $WORKPATH)"
        echo "and set GOPATH accordingly"
        echo
	echo "Add to your shell profile ($HOME/.bashrc, $HOME/.profile)"

   if [[ "$INSTALL" == "0" ]]; then
   	echo "export GOROOT=${INSTALL_DIR}"
   else
   	echo "export GOROOT=${GOROOT}"
   fi
	echo "export GOPATH=$WORKPATH"
        echo "export PATH=${PATH}:${WORKPATH}/bin"
	echo
	echo "To install additional tools, run the go get command:"
	echo "$ go get golang.org/x/tools/cmd/..."
	echo
}

options=$(getopt -o hbuitar: \
-l help,build,update,install,tests,addtools,release: -- "$@")

if [ $? -ne 0 ]; then
    show_help
    exit 1
fi

eval set -- "$options"

while true
do
    case "$1" in
    	-h|--help)      show_help ;;
    	-r|--release)	RELEASE=$2; shift 2;;
    	-b|--build)     BUILD=0; shift 1;;
    	-u|--update)    UPDATE=0; shift 1;;
    	-i|--install)   INSTALL=0; shift 1;;
    	-t|--tests)     TESTS=0; shift 1;;
	-a|--addtools)	ADDTOOLS=0; shift 1;;
    	--) 	    	shift 1; break;;
     	 *)             echo "error!"; exit 1;;
    esac
done

if [[ "$RELEASE" == "0" ]]; then
   show_help;
   exit 1
fi

if ! curl --version &> /dev/null ; then
  echo "curl is not being recognized as a command; install before continuing";
  exit 1
fi

if ! git --version &> /dev/null; then
  echo "git is not being recognized as a command; install before continuing";
  exit 1
fi

if [[ "$INSTALL" == "0" ]]; then
   export GOROOT_FINAL=$INSTALL_PATH
   export GOBIN=$INSTALL_PATH/bin
fi

if [[ "$BUILD" == "0" ]]; then
   echo "### Build $RELEASE"
   if [ -d "$GOROOT" ]; then
      	echo "$GOROOT already exists; remove before continuing"
      	exit 1
   fi
   setup_bootstrap
   fetch_repo
   build_go
   end_msg
   exit 0
elif [[ "$UPDATE" == "0" ]]; then
   echo "### Update to $RELEASE"
   if [ ! -d "$GOROOT/src" ]; then
        echo "Missing $GOROOT/src directory; build before update"
        exit 1
   fi
   update_go
   end_msg
   exit 0
else
  exit 1
fi

