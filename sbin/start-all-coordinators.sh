#!/bin/bash

if [ -z "$RAMCLOUD_HOME" ]
then
  echo "## ERROR"
  echo "RAMCLOUD_HOME env variable is not define"
  exit 1
fi

. "${RAMCLOUD_HOME}/conf/ramcloud-env.sh"

for ip in $(cat "${RAMCLOUD_HOME}/conf/coordinators")
do
  script="${RAMCLOUD_HOME}/sbin/start-daemon.sh ${RAMCLOUD_HOME}/obj.master/coordinator -C ${RAMCLOUD_PROTOCOL}:host=${ip},port=${RAMCLOUD_COORD_PORT} -x ${RAMCLOUD_ZOOKEEPER_LEADER}"

  ssh $ip "${script}" 
done

exit 0
