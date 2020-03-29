#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo "USAGE:"
  echo "$0 COMMAND"
  exit 1
fi


LOG="${HOME}/ramcloud.log"

nohup -- "${@}" > $LOG 2>&1 < /dev/null &
pid="$!"

echo ">> DEAMON RUNNING: ${@} WITH PID: ${pid} WITH LOG FILE: $LOG"

exit 0
