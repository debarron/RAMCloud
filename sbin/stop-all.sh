#!/bin/bash

. "${RAMCLOUD_HOME}"/conf/ramcloud-env.sh

echo "# Terminating with all coordinators"
for ip in $(cat "${RAMCLOUD_HOME}/conf/coordinators")
do
  script="${RAMCLOUD_HOME}/sbin/stop-daemon.sh coordinator"
  ssh $ip "${script}" 
done
echo "# Done"
echo " "

echo "# Terminating with all servers"
for ip in $(cat "${RAMCLOUD_HOME}/conf/servers")
do
  script="${RAMCLOUD_HOME}/sbin/stop-daemon.sh server"
  ssh $ip "${script}" 
done
echo "# Done"

exit 0
