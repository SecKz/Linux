#!/bin/sh
# sh netstat.sh 刷新间隔 刷新次数
if [ $# = 0 ];then
interval=0
count=1
else
interval=$1
count=$2
fi
ips=20

i=0
while [ "$i" -lt "$count" ] ; do
[ $# != 0 ] && clear
echo "-------------80端口请求总数"
netstat -nat | grep ':80' | wc -l
echo "-------------3306端口请求总数"
netstat -nat | grep ':3306' | wc -l
echo "-------------21端口请求总数"
netstat -nat | grep ':21' | wc -l
echo "-------------TCP连接状态请求数"
netstat -ntu | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
echo "-------------前${ips}个ip连接的请求数"
netstat -ntu | awk '{print $5}' | egrep -o "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | fgrep -v '127.0.0.1' | sort | uniq -c | sort -nr | head -$ips
echo "-----------------------------------"
i=$(($i+1))
sleep $interval"s"
done
