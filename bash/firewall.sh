#!/bin/bash
# A simple iptables firewall configuration
# http://www.cnblogs.com/skyfree/p/3708594.html

PATH=/sbin:/bin:/usr/sbin:/usr/bin; export PATH

# 先备份iptables
if [ -f /etc/sysconfig/iptables ]; then
cp -af /etc/sysconfig/iptables /etc/sysconfig/iptables.bak 
fi

#flush/erase original rules
iptables -F #清除所有已制定的rule
iptables -X #清除用户自定义的chain/table
iptables -Z #将所有的chain的计数和流量统计归零

#Accept localhost connetting, no matter what it is
iptables -A INPUT -i lo -j ACCEPT

#Accept any response package which is initiated from inside
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#block most common network attacks(recon packets and syn-flood attack)
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP

#open ports for different services
iptables -A INPUT -p tcp --dport 21 -j ACCEPT 
iptables -A INPUT -p tcp --dport 22 -j ACCEPT 
iptables -A INPUT -p tcp --dport 23 -j ACCEPT 
iptables -A INPUT -p tcp --dport 25 -j ACCEPT 
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 110 -j ACCEPT 
iptables -A INPUT -p tcp --dport 443 -j ACCEPT 
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT 

#ICMP configuration
#To prevent ICMP DDOS,we do not allow ICMP type 8(echo-request) or limit this request with 1/second
#some ICMP requests are allowed.
icmp_type="0 3 4 11 12 14 16 18"
for ticmp in $icmp_type
do
iptables -A INPUT -p icmp --icmp-type $ticmp -j ACCEPT
done
#iptables -A INPUT -p icmp --icmp-type 8 -m limit --limit 1/second -j ACCEPT

#default policies
iptables -P OUTPUT ACCEPT
iptables -P INPUT DROP
