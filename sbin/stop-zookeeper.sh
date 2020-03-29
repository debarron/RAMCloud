#!/bin/bash

if [ -z "$RAMCLOUD_HOME" ]
then
  echo "## ERROR"
  echo "The RAMCLOUD_HOME env variable is not defined"
  exit 1
fi

. "${RAMCLOUD_HOME}"/conf/ramcloud-env.sh

for ip in $(cat "${RAMCLOUD_HOME}/conf/coordinators" "${RAMCLOUD_HOME}/conf/servers")
do
  script="kill -9 \$(jps -lm | grep zookeeper | cut -d' ' -f1)"
  ssh $ip "${script}" > /dev/null
done

exit 0
