#!/bin/bash

if [ "$#" -ne 4 ]; then
  echo "USAGE:"
  echo "$0 MEMORY_MB BACKUP_FILE SEGMENT_FRAMES R"
  exit 1
fi

if [ -z "$RAMCLOUD_HOME" ]
then
  echo "## ERROR"
  echo "The RAMCLOUD_HOME env variable is not defined"
  exit 1
fi

MEMORY="$1"
BACKUP_FILE="$2"
SEGMENT_FRAMES="$3"
R="$4"

. "${RAMCLOUD_HOME}/conf/ramcloud-env.sh"

for ip in $(cat "${RAMCLOUD_HOME}/conf/servers")
do
  script="${RAMCLOUD_HOME}/sbin/start-daemon.sh ${RAMCLOUD_HOME}/obj.master/server -L ${RAMCLOUD_PROTOCOL}:host=${ip},port=${RAMCLOUD_SERVER_PORT} -x ${RAMCLOUD_ZOOKEEPER_LEADER} --totalMasterMemory ${MEMORY} -f ${BACKUP_FILE} --segmentFrames ${SEGMENT_FRAMES} -r ${R}"
  
  ssh $ip "${script}"
done

exit 0
