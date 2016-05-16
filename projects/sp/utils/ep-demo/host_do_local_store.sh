#!/bin/bash

echo "$1" | grep -q "^[1-9]$" || { echo "Usage: `basename $0` <1|2|3|..|9>"; exit 0; }

[ "$2" != "" ] && DURATION_S=$2 || DURATION_S=100
OPT=""
BS=262144
DIRECT="oflag=direct"
CLIENT_IP=192.168.44.1
sync; sysctl -w vm.drop_caches=1 > /dev/null
sleep 5

date
set -x
nuttcp $OPT -Ihost-local-${1} -T${DURATION_S} -P5${1}00 -p5${1}01 -r -fparse -s -l$BS $CLIENT_IP | dd of=/dev/md0 bs=$BS $DIRECT    seek=${1}k
