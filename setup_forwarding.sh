#!/bin/sh
TARGET_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' jitsi-meet)
INTERFACE=wlo1
test -z $1 || TARGET_IP=$1
test -z $2 || INTERFACE=$2
iptables -t nat -A PREROUTING -i ${INTERFACE} -p tcp --dport 5347 -j DNAT --to ${TARGET_IP}:5347
iptables -t nat -A PREROUTING -i ${INTERFACE} -p tcp --dport 80 -j DNAT --to ${TARGET_IP}:80
iptables -t nat -A PREROUTING -i ${INTERFACE} -p tcp --dport 443 -j DNAT --to ${TARGET_IP}:443
iptables -t nat -A PREROUTING -i ${INTERFACE} -p udp --dport 10000:10010 -j DNAT --to ${TARGET_IP}:10000-10010
