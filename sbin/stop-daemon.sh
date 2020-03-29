#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo "USAGE:"
  echo "$0 (coordinator | server)"
  exit 1
fi

PROCESS_TYPE="$1"
PROCESS_INFO=$(ps -uax | grep 'obj.master' | grep "${PROCESS_TYPE}" | grep -v grep | grep -v bash)
PROCESS_ARGS=($PROCESS_INFO)
PID="${PROCESS_ARGS[1]}"
PNAME="${PROCESS_ARGS[10]}"

echo ">> Killing process ${PNAME} (${PID})"
kill -9 "$PID"

exit 0
