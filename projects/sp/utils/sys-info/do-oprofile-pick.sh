#!/bin/bash

usage_exit()
{
	_RET=0
	[ "$*" != "" ] && { echo "$*"; _RET=1; }
	echo "Usage: `basename $0` <file> [PID]..."
	exit $_RET
}

SYM_LIST="vmlinux libc libgcc_s libpthread CPSModule StreamingServer ONVIFAdaptor libsys_api rpc"
#SYM_LIST=

[ "$1" == "" ] && usage_exit
fn="$1"
[ -f "$fn" ] || usage_exit "Error: file not exist or bad file name format [$fn]"

if [ "$SYM_LIST" == "" ]; then
	GREP_OPT="-e ."
else
	GREP_OPT="`for i in $SYM_LIST; do echo -n "-e $i "; done`"
fi
shift
PID_LIST="$*"
CUT_OPT=`echo -n $1; shift; for i in $PID_LIST; do echo -n ,$i; done`


log_head_get_cut_opt_by_pids()
{
	_tmp=""
	for i in $PID_LIST; do
		_col_num=`echo "$log_head" | grep -o ".* $i[^0-9]" | wc -w`
		echo -n "$_tmp$((_col_num-1)),$_col_num"
		_tmp=","
	done
}


line_num=`cat "$fn" | wc -l`
log="`grep -A $line_num "tgid:" "$fn" | grep -v '\--------' | sed -e "s/  */ /g" -e "s/^  *//g"`"
log_head="`echo "$log" | head -n 2 | sed "s/tgid:\([^|]\+\)|/\1 \1/g"`"
log_pids="`echo "$log_head" | head -n 1`"
log_body="`echo "$log" | tail -n +3`"

log_pick="`echo "$log_body" | grep $GREP_OPT`"

CUT_OPT=`log_head_get_cut_opt_by_pids $PID_LIST`
col_last=`echo $log_pids | wc -w`

if [ "$CUT_OPT" == "" ]; then
	CUT_OPT="1-$((col_last+1))"
else
	CUT_OPT="$CUT_OPT,$((col_last+1))"
fi

{ echo "$log_head"; echo "$log_pick"; } | cut -d " " -f $CUT_OPT | column -t

