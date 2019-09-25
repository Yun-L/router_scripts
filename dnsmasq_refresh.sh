#!/bin/bash

# deletes the dnsmasq.conf file, and refreshes dnsmasq
# then adds a new dnsmasq.conf filea and refreshes dnsmasq again

rm /etc/dnsmasq.conf
echo "old dnsmasq.conf removed"
service dnsmasq restart
echo "dnsmasq restarted"

cat dnsmasq_configs.txt >> dnsmasq.conf
echo "new dnsmasq.conf created"

mv dnsmasq.conf /etc/
echo "dnsmasq.conf moved to /etc/"

service dnsmasq restart
echo "dnsmasq restarted"
