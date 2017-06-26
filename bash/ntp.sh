#!/bin/sh
# 定时同步时间
#PATH=/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
log=/root/ntp.log

# 时间服务器列表 http://www.pool.ntp.org/zone/cn
servers="0.cn.pool.ntp.org 0.asia.pool.ntp.org 2.asia.pool.ntp.org"

which ntpdate > $log 2>&1

for i in $servers; do
/sbin/ntpdate -u $i >> $log 2>&1
if [ "$?" = 0 ]; then
echo $i >> $log 2>&1
break
fi

done



