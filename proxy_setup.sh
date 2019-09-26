#!/bin/bash

read -p "Enter Proxy IP: " ip

read -p "Enter Proxy HTTP Port: " port_http

read -p "Enter Proxy HTTPS Port: " port_https


#redirect tcp packets on ports 80 and 443 to proxy machine

iptables -t nat -A PREROUTING -i br0 -p tcp --dport 80 -j DNAT --to-destination "$ip:$port_http"

iptables -t nat -A PREROUTING -i br0 -p tcp --dport 443 -j DNAT --to-destination "$ip:$port_https"

#make sure reply packets get sent back to router

iptables -t nat -A POSTROUTING -o eth0 -s 172.16.0.0/12 -d $ip -j MASQUERADE

#ensure proxy machine receives appropriate packets.

iptables -A FORWARD -s 172.16.0.0/12 -d $ip -i br0 -o eth0 -p tcp --dport $port_http -j ACCEPT

iptables -A FORWARD -s 172.16.0.0/12 -d $ip -i br0 -o eth0 -p tcp --dport $port_https -j ACCEPT

echo "done"
