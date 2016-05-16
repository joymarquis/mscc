NIC_TO_CLIENT=eth5
NIC_TO_CLIENT_IP=192.168.44.11
NIC_TO_EP=eth0
NIC_TO_EP_IP=192.168.100.11

VNET_SRC_=/home/houqing1/sources/svn/pmc_vnet/
VNET_RC=$VNET_SRC_/rc
VNET_RC_MODULE_NAME_=pmc_vnet_rc
VNET_RC_MODULE=$VNET_RC/$VNET_RC_MODULE_NAME_.ko

make -s -C $VNET_RC all

lsmod | grep -q $VNET_RC_MODULE_NAME_ || insmod $VNET_RC_MODULE

ifconfig $NIC_TO_EP $NIC_TO_EP_IP mtu 9202 up
ifconfig $NIC_TO_CLIENT $NIC_TO_CLIENT_IP mtu 9202 up

sysctl -w net.ipv4.conf.all.forwarding=1 >/dev/null
