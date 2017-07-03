#!/usr/bin/env sh

iptables -F
iptables -F -t nat

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT

iptables -A FORWARD -i eth0 -p tcp -d 0.0.0.0/0 -j ACCEPT

iptables -t nat -A POSTROUTING -o eth0 -s 10.255.1.0/24 -j MASQUERADE

sudo service iptables save
