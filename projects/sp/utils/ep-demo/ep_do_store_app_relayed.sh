#!/bin/bash

echo "$1" | grep -q "^[1-9]$" || { echo "Usage: `basename $0` <1|2|3|..|9>"; exit 0; }

[ "$2" != "" ] && DURATION_S=$2 || DURATION_S=100
OPT="-i 10"
BS=262144
DIRECT="oflag=direct"
NIC=eth0
HOST_IP=192.168.100.11
ethtool -k $NIC tx off
echo f > /sys/class/net/$NIC/queues/rx-0/rps_cpus
echo 4096 > /sys/class/net/$NIC/queues/rx-0/rps_flow_cnt
sysctl -w net.ipv4.tcp_dma_copybreak=1024 > /dev/null
sync; sysctl -w vm.drop_caches=1 > /dev/null
sleep 5

date
set -x
nuttcp $OPT -Iep-relay-${1} -T${DURATION_S} -P5${1}00 -p5${1}01 -r -fparse -s -l$BS $HOST_IP | dd of=/dev/md0 bs=$BS $DIRECT    seek=${1}k
