#!/bin/bash

VER=v03

INTERVAL=5
COUNT=12
NIC0=eth0
NIC1=eth1

DATE_FMT="+--ts--%Y%m%d-%H:%M:%S"

DIR=log-$VER-`date +%Y%m%d-%H%M%S`
PID=$$

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


err_exit()
{
	echo $*
	exit 1
}


grep -q "${NIC0}:" /proc/net/dev || err_exit "[NIC0=$NIC0] does not exist, edit me"
grep -q "${NIC1}:" /proc/net/dev || err_exit "[NIC0=$NIC1] does not exist, edit me"

do_cleanup()
{
	killall iostat mpstat pidstat 2>/dev/null
}

check_parent()
{
	if kill -0 $PID 2>/dev/null; then
		true
	else
		do_cleanup
	       	err_exit "parent [PID=$PID] terminates, exit now"
	fi
}

get_net_stat()
{
	for i in `seq $COUNT`; do { check_parent; date $DATE_FMT; netstat -su; } >>$LOG_NET; sleep $INTERVAL; done
}

get_netstat_stat()
{
	for i in `seq $COUNT`; do { check_parent; date $DATE_FMT; netstat -anup; } >>$LOG_NETSTAT; sleep $INTERVAL; done
}

get_nic0_stat()
{
	for i in `seq $COUNT`; do { check_parent; date $DATE_FMT; ethtool -S $NIC0; } >>$LOG_NIC0; sleep $INTERVAL; done
}


get_nic1_stat()
{
	for i in `seq $COUNT`; do { check_parent; date $DATE_FMT; ethtool -S $NIC1; } >>$LOG_NIC1; sleep $INTERVAL; done
}

get_mem_stat()
{
	for i in `seq $COUNT`; do { check_parent; date $DATE_FMT; grep -e "^Low" -e "^Mem" /proc/meminfo; } >> $LOG_MEM; sleep $INTERVAL; done
}

# prepare
mkdir -p $DIR || err_exit "failed creating directory [$DIR], exit now"
do_cleanup

# info pre
echo > $LOG_INFO
uname -a >> $LOG_INFO
lsmod >> $LOG_INFO
sysctl -a | grep mem >> $LOG_INFO
cat /proc/interrupts >> $LOG_INFO
ps -eLFl >> $LOG_INFO

# stats
get_net_stat &
get_netstat_stat &
get_nic0_stat &
get_nic1_stat &
get_mem_stat &
iostat -zxt $INTERVAL $COUNT > $LOG_IO &
mpstat -A $INTERVAL $COUNT > $LOG_MP &

pidstat -tlw $INTERVAL $COUNT > $LOG_PS_SW &
pidstat -t -T CHILD $INTERVAL $COUNT > $LOG_PS_MS &
pidstat -tl $INTERVAL $((COUNT++)) | tee $LOG_PS_CPU

# info post
cat /proc/interrupts >> $LOG_INFO
ps -eLFl >> $LOG_INFO

echo
echo "system stat logging completed, logs are saved to dir"
echo " * [$DIR]"


