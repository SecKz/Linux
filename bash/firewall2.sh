#!/bin/sh
# http://blog.csdn.net/zqtsx/article/details/9405515
# 先备份原来的/etc/sysconfig/iptables文件
cp /etc/sysconfig/iptables /etc/sysconfig/iptables.bak

#防止SYN攻击 轻量级预防   
iptables -N syn-flood   (如果您的防火墙默认配置有“ :syn-flood - [0:0] ”则不许要该项，因为重复了)
iptables -A INPUT -p tcp --syn -j syn-flood   
iptables -I syn-flood -p tcp -m limit --limit 3/s --limit-burst 6 -j RETURN   
iptables -A syn-flood -j REJECT   
#防止DOS太多连接进来,可以允许外网网卡每个IP最多15个初始连接,超过的丢弃   
iptables -A INPUT -i eth0 -p tcp --syn-m connlimit --connlimit-above 15 -j DROP   
iptables -A INPUT -p tcp-m state --state ESTABLISHED,RELATED -j ACCEPT  
  
#用Iptables抵御DDOS (参数与上相同)   
iptables -A INPUT  -p tcp --syn -m limit --limit 12/s --limit-burst 24 -j ACCEPT  
iptables -A FORWARD -p tcp --syn -m limit --limit 1/s -j ACCEPT  
##########################################################   