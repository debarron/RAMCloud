#!/bin/bash

for machine in $(cat $RAMCLOUD_HOME/conf/coordinators $RAMCLOUD_HOME/conf/servers)
do
  scp $RAMCLOUD_HOME/conf/ramcloud-env.sh $machine:$RAMCLOUD_HOME/conf/
done

