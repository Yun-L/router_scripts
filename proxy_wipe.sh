#!/bin/bash

read -p "Enter Proxy IP: " ip
read -p "Enter Proxf HTTP Port: " port_http
read -p "Enter Proxy HTTPS Port: " port_https

# removing iptable rules for forwarding packets to the proxy

iptables -t nat -D PREROUTING -i br0 -p tcp --dport 80 -j DNAT --to-destination "$ip:$port_http"

iptables -t nat -D PREROUTING -i br0 -p tcp --dport 443 -j DNAT --to-destination "$ip:$port_https"

iptables -t nat -D POSTROUTING -o eth0 -s 172.16.0.0/12 -d $ip -j MASQUERADE

iptables -D FORWARD -s 172.16.0.0/12 -d $ip -i br0 -o eth0 -p tcp --dport $port_http -j ACCEPT

iptables -D FORWARD -s 172.16.0.0/12 -d $ip -i br0 -o eth0 -p tcp --dport $port_https -j ACCEPT

echo "rules deleted"
