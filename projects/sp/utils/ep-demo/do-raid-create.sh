#!/bin/bash

MD=md0
DEVS=/dev/sd[bcde]
DEVS_ADD=/dev/sdf

mdadm --stop /dev/$MD
mdadm --create /dev/$MD --run --size=8G --chunk=64 --level=5 --raid-devices=5 $DEVS missing
mdadm /dev/$MD --add $DEVS_ADD

sleep 1

cat /proc/mdstat

