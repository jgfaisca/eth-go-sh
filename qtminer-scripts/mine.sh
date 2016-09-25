#!/bin/bash
#
# GPU ethereum mining with ethermine pool
#

QTMINER_DIR=$HOME/qtminer

export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_HEAP_SIZE=100

# run command
function evalCMD(){
	CMD=$1
	echo "$CMD"
	eval "$CMD"
}

# mine specific GPU card
function mineGPU(){
	SERVER="$1" # stratum server
	ADDRESS="$2" # ethereum address
	RIG="$3" # rig name
	OCLDEVICE="$4" # GPU card nr
	evalCMD "$QTMINER_DIR/qtminer.sh -s $SERVER -u $ADDRESS.$RIG -G --opencl-device '$OCLDEVICE'"
}

# start all GPU cards mining
function mineAllGPU(){
        SERVER="$1" # stratum server
        ADDRESS="$2" # ethereum address
        RIG="$3" # rig name
        OCLDEVICE="$4"
        evalCMD "$QTMINER_DIR/qtminer.sh -s $SERVER -u $ADDRESS.$RIG -G"
}

# start all CPU mining
function mineAllCPU(){
        SERVER="$1" # stratum server
        ADDRESS="$2" # ethereum address
        RIG="$3" # rig name
        evalCMD "./qtminer.sh -s $SERVER -u $ADDRESS.$RIG"
}

mineGPU "eu1.ethermine.org:4444" "0xff43ccd97950194ceec7848eab986b63f755016c" "rig1" "0"


