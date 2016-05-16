#!/bin/bash

killall redir >/dev/null 2>&1
sleep 2
killall -9 redir >/dev/null 2>&1

sysctl -w net.ipv4.conf.all.forwarding=1 >/dev/null
