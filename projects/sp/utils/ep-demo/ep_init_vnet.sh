NIC=eth0
NIC_IP=192.168.100.4
NIC_HOST_IP=192.168.100.11

ifconfig $NIC $NIC_IP mtu 9202 up

route del default >/dev/null 2>&1
route add default gw $NIC_HOST_IP
