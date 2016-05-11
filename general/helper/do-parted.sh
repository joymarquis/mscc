#!/bin/bash

[ "$*" == "" ] && { echo "Usage: `basename $0` <DEV>"; exit 1; }

PARTED="parted -s -a opt"

DEV=$*
[ "$LM" == "" ] && LM=8192

for i in $DEV; do
	${PARTED} $i mklabel msdos
	#${PARTED} $i rm 1 > /dev/null 2>&1
	#${PARTED} $i rm 2 > /dev/null 2>&1
	#${PARTED} $i rm 3 > /dev/null 2>&1
	#${PARTED} $i rm 4 > /dev/null 2>&1
	${PARTED} $i mkpart primary 1M 8G
	${PARTED} $i mkpart primary 8G 16G
	#${PARTED} $i mkpart primary 16G 24G
	#${PARTED} $i mkpart primary 24G 32G
	${PARTED} $i unit compact print
done

