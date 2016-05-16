#!/bin/bash

[ "$1" != "yes" ] && { echo "Read and modify me before execute"; exit 1; }

mdadm --stop /dev/md[0123]
mdadm --misc --zero-superblock /dev/sd[b-z]
