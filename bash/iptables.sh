#!/bin/sh
# http://www.simplehelp.net/2009/04/06/how-to-block-an-ip-address-in-iptables-in-linux/
# http://www.cyberciti.biz/faq/how-do-i-block-an-ip-on-my-linux-server/
# http://www.cyberciti.biz/tips/linux-iptables-10-how-to-block-common-attack.html
# 有参数0为时，解除ip封锁 

blacklist='banned_IPs.txt'

if [ ! -f "$blacklist" ]; then
echo ${blacklist}不存在
exit 1
fi


if [ $# = 1 -a  "$1" = 0 ]; then
for i in $(< $blacklist) ; do
RETRUN=$(iptables -L -n|fgrep "$i")
if [ -n "$RETRUN" ]; then
iptables -D INPUT -s "$i" -j DROP
fi
done
# 添加到黑名单
else
for i in $(< $blacklist) ; do
RETRUN=$(iptables -L -n|fgrep "$i"|fgrep 'DROP')
if [ -z "$RETRUN" ]; then
iptables -I INPUT -s "$i" -j DROP
fi
done
fi

