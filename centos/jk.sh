#!/bin/sh
# 网站，服务器监控
# 0 */2 * * * /root/centos/jk.sh

urls="58.64.177.172 58.64.177.168 58.64.177.135 58.64.177.183 218.241.10.158 211.22.125.102 211.22.125.29 211.22.125.59 58.64.177.192 58.64.177.233 58.64.177.228 58.64.177.224 58.64.177.221 58.64.177.212"
IP=$(/sbin/ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
str=''

for url in $urls; do
curl -s -I --connect-timeout 10 -m 30 $url > /dev/null 2>&1;
if [ $? -ne 0 ]; then
str="${str}$url, "
fi
done

str=${str%,*}

if [ -n "$str" ]; then
echo $str
echo "$str" | mail -s '以下服务器要检查!' 260741887@qq.com
#echo "$str" | mail -s '以下服务器要检查!' 382999761@qq.com
fi


