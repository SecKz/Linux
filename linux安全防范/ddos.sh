#!/bin/sh
# drop掉ESTABLISHED超过100的ip
# */1 * * * * /root/centos/dropip.sh
netstat -na|grep ESTABLISHED|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|sort -rn|head -10|grep -v -E '192.168|127.0'|awk '{if ($2!=null && $1>100) {print $2}}'
for i in $(cat /tmp/dropip)
do        
    /sbin/iptables -A INPUT -s $i -j DROP        
    echo "$i kill at date">>/var/log/ddos
done
