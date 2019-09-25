#!/bin/bash

# deletes the dnsmasq.conf file, and refreshes dnsmasq
# then adds a new dnsmasq.conf filea and refreshes dnsmasq again

rm /etc/dnsmasq.conf
echo "old dnsmasq.conf removed"
service dnsmasq restart
echo "dnsmasq restarted"

echo "interface=br0
dhcp-range=172.16.0.10,172.31.255.254,8h
dhcp-option=3,172.16.0.1
dhcp-option=6,172.16.0.1
server=8.8.8.8
log-queries
log-dhcp

# include addresses" >> dnsmasq.conf
echo "new dnsmasq.conf created"

mv dnsmasq.conf /etc/
echo "dnsmasq.conf moved to /etc/"

service dnsmasq restart
echo "dnsmasq restarted"
