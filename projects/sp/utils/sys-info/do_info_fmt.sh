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

grep -e "Device:" -m1 $LOG_IO > $LOG_IO$SUFF
grep -e "^../../.." -e "sd[a-z]" $LOG_IO >> $LOG_IO$SUFF

grep -e "Free" -e "--ts--" $LOG_MEM > $LOG_MEM$SUFF

grep -e "%idle" -A5 $LOG_MP > ${LOG_MP}_cpu$SUFF
grep -e "6/s" -A4 $LOG_MP | sed "s/ \+/\t/g" | cut -d "	" -f 1,2,5 > ${LOG_MP}_int$SUFF
grep -e "NET_RX" -A4 $LOG_MP | sed "s/ \+/\t/g" | cut -d "	" -f 1,2,4,5,6 > ${LOG_MP}_si$SUFF

grep -e "Udp:" -A4 $LOG_NET > ${LOG_NET}_udp$SUFF
grep -e "Udp:" -A1 $LOG_NET | grep -o "[0-9]\+" | do_calc_delta > ${LOG_NET}_udp_delta$SUFF

#grep -e "Udp:" -A4 $LOG_NET > ${LOG_NET}_udp$SUFF

for i in $LOG_NIC0 $LOG_NIC1; do
	grep -e "NIC" -e "rx_" $i > ${i}_rx$SUFF
	grep -e "NIC" -e "tx_" $i > ${i}_tx$SUFF
	grep -e "rx_ucast_packets:" $i | grep -o "[0-9]\+" | do_calc_delta > ${i}_rx_pkts_delta$SUFF
	grep -e "rx_bytes:" $i | grep -o "[0-9]\+" | do_calc_delta > ${i}_rx_bytes_delta$SUFF
done

for i in $LOG_PS_CPU $LOG_PS_MS $LOG_PS_SW; do
	grep -e "|__" -e "Command$" $i > ${i}_thr$SUFF
done

