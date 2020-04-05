#!/bin/bash

# Reset RAMCloud Env with new zookeeper leader
# We ASSUME THAT RAMCLOUD_HOME EXISTS

ZOO_LEADER="$1"

. $RAMCLOUD_HOME/conf/ramcloud-env.sh

leader="export RAMCLOUD_ZOOKEEPER_LEADER=\"zk:${ZOO_LEADER}:${RAMCLOUD_ZOOKEEPER_PORT}\""
prev_env=$(cat $RAMCLOUD_HOME/conf/ramcloud-env.sh | grep -v RAMCLOUD_ZOOKEEPER_LEADER)

echo "$prev_env" > $RAMCLOUD_HOME/conf/ramcloud-env.new
echo "$leader" >> $RAMCLOUD_HOME/conf/ramcloud-env.new

mv $RAMCLOUD_HOME/conf/ramcloud-env.new $RAMCLOUD_HOME/conf/ramcloud-env.sh
chmod u+x $RAMCLOUD_HOME/conf/ramcloud-env.sh

