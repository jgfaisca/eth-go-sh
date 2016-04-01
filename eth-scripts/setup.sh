#!/bin/bash

# script name
BASEN=$(basename $BASH_SOURCE)

# help message
function show_help(){
  echo "usage: ./$BASEN <--amd/--nvidia>"
  exit 1
}

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

if [ $# != 1 ] ; then
   show_help;
fi

while [ $# -gt 0 ]; do
    case "$1" in
        --amd)
            OPENCL="ocl-icd-opencl-dev xserver-xorg-video-ati"
            shift
            ;;
        --nvidia)
            OPENCL="nvidia-opencl-dev"
            ;;
        *)
            show_help
            ;;
    esac
    shift
done

# install nodejs
node --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "node is not being recognized as a command; installing ...";
  (exec "./install_nodejs.sh")
fi

# install golang
go version >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "go is not being recognized as a command; installing ...";
  (exec "./install_golang.sh")
fi

# update packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y software-properties-common

# add ethereum repos
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo add-apt-repository -y ppa:ethereum/ethereum-dev
sudo apt-get update -y

# install additional packages
sudo apt-get install -y git curl build-essential unzip wget ntp

# installation on an Ubuntu EC2 Instance (optional)
#sudo apt-get install -y cloud-utils

# instatall opencl-dev
sudo apt-get install -y $OPENCL

# set up time update cronjob
sudo bash -c "cat > /etc/cron.hourly/ntpdate << EOF
#!/bin/sh
pm2 flush
sudo service ntp stop
sudo ntpdate -s ntp.ubuntu.com
sudo service ntp start
EOF"

sudo chmod 755 /etc/cron.hourly/ntpdate

# install pm2
sudo npm install pm2 -g

# install eth-net-intelligence-api
(exec "./install_eth-net-intelligence-api.sh")

# install go-ethereum
(exec "./install_go-ethereum.sh")

# install go-ethereum service
tmpfile=$(mktemp /tmp/ethereum.XXXXXX)
cp resources/ethereum $tmpfile
replaceVar "USER_NAME" "$U" "$tmpfile" &&
sudo cp $tmpfile /etc/init.d/ethereum &&
rm $tmpfile

# configure go-ethereum service to run at startup
sudo update-rc.d ethereum defaults

# username
U=$(whoami)

# hostname
H="eth"
H0=$(ssh-keygen -l -f /etc/ssh/ssh_host_rsa_key.pub)
H1=$(echo $H0 $(uname -snmpio) | md5sum)
H2="${H1:0:13}"
H3="$H$H2"

# update net intelligence api configuration
cp resources/app.json $HOME/eth-net-intelligence-api/ && 
replaceVar "I_NAME" "$H3" "$HOME/eth-net-intelligence-api/app.json" &&
replaceVar "C_DETAILS" "${U}\@${H3}" "$HOME/eth-net-intelligence-api/app.json" && 

exit 0
