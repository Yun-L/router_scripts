#!/bin/bash

# removes iptable rules

ifconfig br0 down
echo "bring br0 down"

brctl delbr br0
echo "deleting br0"

iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
echo "removing forwarding iptable rule"


