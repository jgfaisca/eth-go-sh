#!/bin/bash
#
# Remove old DAG files
#

FILE=$(lsof -c qtminer | grep full-R23 | grep -v mem | awk '{print $9}')
DIR=$(dirname "${FILE}")
echo $DIR
FILE=$(basename $FILE)
echo $FILE
cd $DIR
ls | grep -v $FILE | xargs rm
cd ..

