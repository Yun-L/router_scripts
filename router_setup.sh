#!/bin/bash

# sets up the bridged network interface and iptable rules

apt-get install bridge-utils
ip addr flush dev eth1
echo "flush ip from eth1"

brctl addbr br0
echo "create br0 interface"

brctl addif br0 eth1
echo "add eth1 to br0"

ip link set dev br0 up
echo "bring br0 up"

ip addr add 172.16.0.1/12 dev br0

sysctl -w net.ipv4.ip_forward=1
iptables -P FORWARD ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
echo "set iptables rules"
