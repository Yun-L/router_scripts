#!/bin/bash

# removes iptable rules

ifconfig br0 down
brctl delbr br0
iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE


