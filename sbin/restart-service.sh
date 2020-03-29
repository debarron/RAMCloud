#!/bin/bash
if [ "$#" -ne 3 ]; then
  echo "USAGE:"
  echo "$0 MEMORY_MB BACKUP_FILE R"
  exit 1
fi

MEMORY_MB="$1"
BACKUP_FILE="$2"
R="$3"

./stop-all.sh
./stop-zookeeper.sh
./exec-in-all.sh "rm -Rf /mydata/rc; rm -Rf /mydata/zoo/version*; mkdir /mydata/rc"
./get-zookeeper-leader.sh
./copy-ramcloud-env.sh

./start-all.sh $MEMORY_MB $BACKUP_FILE $R
