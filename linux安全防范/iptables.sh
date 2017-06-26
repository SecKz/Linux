#!/bin/sh
# http://www.cszhi.com/20111010/iptables-remission-ddos-cc.html
# http://sookk8.blog.51cto.com/455855/321242

#防止SYN攻击 轻量级预防 
iptables -N syn-flood 
iptables -A INPUT -p tcp --syn -j syn-flood 
iptables -I syn-flood -p tcp -m limit --limit 3/s --limit-burst 6 -j RETURN 
iptables -A syn-flood -j REJECT

#防止DOS太多连接进来,可以允许外网网卡每个IP最多15个初始连接,超过的丢弃 
iptables -A INPUT -i eth0 -p tcp --syn -m connlimit --connlimit-above 15 -j DROP 
iptables -A INPUT -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT

#用Iptables抵御DDOS (参数与上相同)
iptables -A INPUT  -p tcp --syn -m limit --limit 12/s --limit-burst 24 -j ACCEPT
iptables -A FORWARD -p tcp --syn -m limit --limit 1/s -j ACCEPT

# 缓解CC攻击
iptables -I INPUT -p tcp --dport 80 -m connlimit  --connlimit-above 25 -j REJECT #允许单个IP的最大连接数为25个
iptables -A INPUT -p tcp --dport 80 -m recent --name BAD_HTTP_ACCESS --update --seconds 60 --hitcount 30 -j REJECT
iptables -A INPUT -p tcp --dport 80 -m recent --name BAD_HTTP_ACCESS --set -j ACCEPT
