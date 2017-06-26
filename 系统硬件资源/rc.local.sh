#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.

modprobe ip_conntrack
/sbin/sysctl -p
touch /var/lock/subsys/local
/usr/local/bin/rsync --daemon
arp -f /etc/ethers

# Create by ChenPeng 2011.03.14
# iptables -A INPUT -p tcp --syn -m limit --limit 10/s -j ACCEPT

ulimit -SHn 65535
service iptables start
service mysqld start

echo "30">/proc/sys/net/ipv4/tcp_fin_timeout
echo "1800">/proc/sys/net/ipv4/tcp_keepalive_time 
echo "0">/proc/sys/net/ipv4/tcp_window_scaling
echo "0">/proc/sys/net/ipv4/tcp_sack 
echo "0">/proc/sys/net/ipv4/tcp_timestamps
