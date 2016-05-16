#!/bin/bash

echo "$1" | grep -q "^[1-9]$" || { echo "Usage: `basename $0` <1|2|3|..|9>"; exit 0; }

[ "$2" != "" ] && DURATION_S=$2 || DURATION_S=200
OPT="-i 10 -N64"
OPT="$OPT -u -R256.1M"

BS=32
BS=736
BS=1400
BS=1472
BS=1473
BS=2944
BS=2945
BS=31072	# ?!
BS=64768
BS=64769
BS=65507


BS=1400


BS_DD=128k
DIRECT="oflag=direct"
CLIENT_IP=192.168.100.1

date
set -x
taskset 0x4 nuttcp $OPT -T${DURATION_S} -P5${1}00 -p5${1}01 -r -fparse -l$BS $CLIENT_IP
date
