#!/bin/bash

# WE ASSUME RAMCLOUD_HOME EXISTS

# Basic roadmap is:
# connect to all ramcloud-machines
# get status
# find leader
# get ip
# echo ip

ip=""
for machine in $(cat $RAMCLOUD_HOME/conf/coordinators $RAMCLOUD_HOME/conf/servers)
do
  status=$(ssh $machine "$RAMCLOUD_HOME/zookeeper/bin/zkServer.sh status 2< /dev/null | sed 's/Mode: //g'")
  [ "$status" == "leader" ] && ip="$machine"
done

echo "$ip"
