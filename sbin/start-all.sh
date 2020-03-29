#!/bin/bash
if [ "$#" -ne 3 ]; then
  echo "USAGE:"
  echo "$0 MEMORY_MB BACKUP_FILE R"
  exit 1
fi

if [ -z "$RAMCLOUD_HOME" ]
then
  echo "## ERROR"
  echo "The RAMCLOUD_HOME env variable is not defined"
  exit 1
fi

MEMORY_MB="$1"
BACKUP_FILE="$2"
R="$3"

SEGMENT_FRAMES=$(expr "${MEMORY_MB}" \* "${R}" \* 2)

echo ">> Starting the coordinators"
$RAMCLOUD_HOME/sbin/start-all-coordinators.sh 

echo ">> Starting all servers"
$RAMCLOUD_HOME/sbin/start-all-servers.sh $MEMORY_MB $BACKUP_FILE $SEGMENT_FRAMES $R 

exit 0
