#!/bin/bash
#
# qtminer service setup
#

# run command
function evalCMD(){
	CMD=$1
	echo "$CMD"
	eval "$CMD"
}

# replace file values
function replaceVar(){
 	VAR1="$1"
  	VAR2="$2"
  	FILE="$3"
  	evalCMD "perl -pi -e 's/$VAR1/$VAR2/g' $FILE"
}

# username
U=$(whoami)

# install qtminer service
tmpfile=$(mktemp /tmp/qtminer.XXXXXX)
cp resources/qtminer $tmpfile
replaceVar "USER_NAME" "$U" "$tmpfile" &&
sudo cp $tmpfile /etc/init.d/qtminer &&
sudo chmod 0755 /etc/init.d/qtminer &&
rm $tmpfile

# configure qtminer service to run at startup
sudo update-rc.d qtminer defaults

exit 0
