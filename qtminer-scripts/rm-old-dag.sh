#!/bin/bash
#
# Remove old DAG files
#

FILE=$(lsof -c qtminer | grep full-R23 | grep -v mem | awk '{print $9}')

counter=0
for F in $FILE; do
    DIR=$(dirname "${F}")
    F=$(basename $F)
    let counter++
done

if [[ "$counter" -eq 1 ]]; then
   cd $DIR
   ls | grep -v $F | xargs rm
   [ $? -eq 0 ] || echo "old DAGs removed" && echo "nothing to remove"
   cd ..
else
   echo "skip remove"
fi
