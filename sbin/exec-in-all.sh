#!/bin/bash

if [ -z "$RAMCLOUD_HOME" ]
then
  echo "## ERROR"
  echo "Make sure to set RAMCLOUD_HOME env variable to RAMCloud's install directory"
  exit 1
fi

RAMCLOUD_CONF="$RAMCLOUD_HOME/conf"

if [ ! -d "$RAMCLOUD_CONF" ]
then
  echo "## ERROR "
  echo "Directory $RAMCLOUD_CONF does not exists, install the RAMCloudServices repository in order to continue"
  exit 1
fi

CMD="$1"
for ip in $(cat "$RAMCLOUD_CONF/coordinators" "$RAMCLOUD_CONF/servers")
do
  ssh $ip "$CMD"
done

exit 0
