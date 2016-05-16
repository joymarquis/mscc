#!/bin/bash

NIC0=eth0
NIC1=eth1

DIR="$1"

LOG_INFO="$DIR/_info.log"
LOG_PS_SW="$DIR/ps_sw.log"
LOG_PS_MS="$DIR/ps_ms.log"
LOG_PS_CPU="$DIR/ps_cpu.log"
LOG_MP="$DIR/mp.log"
LOG_IO="$DIR/io.log"
LOG_MEM="$DIR/mem_raw.log"
LOG_NET="$DIR/net.log"
LOG_NETSTAT="$DIR/netstat.log"
LOG_NIC0="$DIR/nic_${NIC0}_raw.log"
LOG_NIC1="$DIR/nic_${NIC1}_raw.log"

SUFF=".txt"


err_exit()
{
	echo $*
	exit 1
}

do_calc_delta()
{
	val_list=""
	while read l; do
		val_list="$val_list $l"
	done

	old=-1
	for i in $val_list; do
		[ "$old" == "-1" ] && { old=$i; continue; }
		echo $((i-old))
		old=$i
	done
}

[ "$1" == "" ] && err_exit "Usage: `basename $0` <log_dir>"
[ -d "$1" ] || err_exit "Dir not exist [$1]"


#grep -e "Linux" -e "Module" -e "wmem" -e "rmem" -e "tcp" -e "udp" -e "CPU0" -e "eth" $LOG_INFO > $LOG_INFO$SUFF


# IO
_dev_list=`grep -o "sd[a-z]* " $LOG_IO | sort | uniq`
_fmt_log=`grep -e "^../../.." -e "sd[a-z]" -e "Device:" $LOG_IO | sed -e "s/,/;/g" -e "s/ \+/,/g"`
for i in $_dev_list; do
	_csv_fn=$LOG_IO.$i.csv
	echo $_csv_fn
	{
		echo -n "timestamp,"
		echo "$_fmt_log" | grep -m1 "Device:"
		_fmt_log_tmp="`echo "$_fmt_log" | grep -e "^../../.." -e "$i,"`"
		#echo "$_fmt_log_tmp"
		prev=""
		while read l; do
			if [ "$prev" != "" ]; then
				if echo "$l" | grep -q "$i,"; then
					echo "`echo $prev | tr "," "_"`,$l"
				fi
			fi
			prev=$l
		done <<< "$_fmt_log_tmp"
	} >$_csv_fn
done

# MEM
_key_list="MemFree LowFree"
_csv_fn=$LOG_MEM.csv
	echo $_csv_fn
{
	echo -n "timestamp,"
	echo "$_key_list" | sed "s/ \+/,/g"
	_ts_prev=""
	while read l; do
		if echo "$l" | grep -q -v "\-\-ts\-\-"; then
			eval `echo "$l" | sed "s/:[ \t]*/=/g;s/kB//g"`
		else
			if [ "$_ts_prev" != "" ]; then
				echo -n "$_ts_prev"
				for k in $_key_list; do
					eval echo -n ,\${$k}
				done
				echo
			fi
			_ts_prev=$l
		fi
	done < $LOG_MEM
} >$_csv_fn

# MP
_fmt_log="`sed "s/ \+/,/g" $LOG_MP`"
{
	# CPU
	_csv_fn=$LOG_MP.cpu.csv
	echo $_csv_fn
	{
		echo "$_fmt_log" | grep -m1 "%idle"
		echo "$_fmt_log" | grep -A5 "%idle" | grep -v -e "^--" -e "%idle"
	} >$_csv_fn
	# INT
	_csv_fn=$LOG_MP.int.csv
	echo $_csv_fn
	{
		echo "$_fmt_log" | grep -m1 "6/s"
		echo "$_fmt_log" | grep -A4 "6/s" | grep -v -e "^--" -e "6/s"
	} >$_csv_fn
	# SI
	_csv_fn=$LOG_MP.si.csv
	echo $_csv_fn
	{
		echo "$_fmt_log" | grep -m1 "NET_RX"
		echo "$_fmt_log" | grep -A4 "NET_RX" | grep -v -e "^--" -e "NET_RX"
	} >$_csv_fn
}

# NET
{
	# UDP
	_csv_fn=$LOG_NET.udp.csv
	echo $_csv_fn
	_fmt_log="`grep -A4 -e "Udp:" -e "\--ts--" $LOG_NET | grep -e "\--ts--" -e "packet" | sed "s/^[ \t]\+\([0-9]\+\).*$/\1/g"`"
	{
		echo "timestamp,rcvd,rcvd_unknown,rcvd_error,sent"
		_ts_prev=""
		_row=""
		while read l; do
			if echo "$l" | grep -q -v "\-\-ts\-\-"; then
				_row="$_row,$l"
			else
				if [ "$_ts_prev" != "" ]; then
					echo "$_ts_prev$_row"
				fi
				_ts_prev=$l
				_row=""
			fi
		done <<< "$_fmt_log"
	} >$_csv_fn
}

# NETSTAT
{
	# UDP
	_csv_fn=$LOG_NETSTAT.udp.csv
	echo $_csv_fn
	_fmt_log="`grep "StreamingServer" $LOG_NETSTAT | sed "s/ \+/ /g" | cut -d " " -f 4 | sort | uniq`"
	{
		echo "port_total,port_rtp,port_rtsp"
		echo -n "`echo "$_fmt_log" | wc -l`,"
		echo -n "`echo "$_fmt_log" | grep "[24680]$" | wc -l`,"
		echo -n "`echo "$_fmt_log" | grep "[13579]$" | wc -l`"
	} >$_csv_fn
}

# NIC
_key_list="rx_bytes rx_error_bytes rx_filtered_packets rx_ucast_packets rx_mcast_packets rx_bcast_packets"
_key_list="$_key_list tx_bytes tx_error_bytes tx_ucast_packets tx_mcast_packets tx_bcast_packets"
_key_list="$_key_list rx_64_byte_packets rx_65_to_127_byte_packets rx_128_to_255_byte_packets rx_256_to_511_byte_packets rx_512_to_1023_byte_packets rx_1024_to_1522_byte_packets rx_1523_to_9022_byte_packets"

for f in $LOG_NIC0 $LOG_NIC1; do
	_csv_fn=$f.csv
	echo $_csv_fn
	_fmt_log="`grep -v "NIC statistics:" $f | sed "s/:[ \t]\+/=/g"`"
	{
		echo -n "timestamp,"
		echo "$_key_list" | sed "s/ \+/,/g"
		_ts_prev=""
		while read l; do
			if echo "$l" | grep -q -v "\-\-ts\-\-"; then
				eval "$l"
			else
				if [ "$_ts_prev" != "" ]; then
					echo -n "$_ts_prev"
					for k in $_key_list; do
						#echo -n $k
						eval echo -n ,\${$k}
					done
					echo
				fi
				_ts_prev=$l
			fi
		done <<< "$_fmt_log"
	} >$_csv_fn
done

