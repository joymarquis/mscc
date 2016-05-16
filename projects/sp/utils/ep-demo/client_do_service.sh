#!/bin/bash

# Demo supports only maxium 4 sessions
echo "$1" | grep -q "^[1-9]$" || { echo "Usage: `basename $0` <1|2|3|4>"; exit 0; }

set -x
nuttcp -S --no3rdparty -P5${1}00 --idle-data-timeout 60/80/120
