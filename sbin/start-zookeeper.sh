#!/bin/bash

if [ -z "$RAMCLOUD_HOME" ]
then
  echo "## ERROR"
  echo "The RAMCLOUD_HOME env variable is not defined"
  exit 1
fi

. "${RAMCLOUD_HOME}/conf/ramcloud-env.sh"

for ip in $(cat "${RAMCLOUD_HOME}/conf/coordinators" "${RAMCLOUD_HOME}/conf/servers")
do
  ssh $ip "$RAMCLOUD_HOME/zookeeper/bin/zkServer.sh start"
done

exit 0
