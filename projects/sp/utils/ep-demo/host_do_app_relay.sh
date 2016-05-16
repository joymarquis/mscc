#!/bin/bash

echo "$1" | grep -q "^[1-9]$" || { echo "Usage: `basename $0` <1|2|3|..|9>"; exit 0; }

[ "$2" != "" ] && DURATION_S=$2 || DURATION_S=100
BS=262144
CLIENT_IP=192.168.44.1
EP_IP=192.168.100.4

date
set -x
redir --lport=5${1}00 --cport=5${1}00 --caddr=$CLIENT_IP &
redir --bufsize=$BS --lport=5${1}01 --cport=5${1}01 --caddr=$EP_IP &
