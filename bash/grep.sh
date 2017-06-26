#!/bin/sh
#

if [ -z "$1" ]; then
echo '请输入要查找的字符串'
exit 
fi

grep -rl "$1" /root/nconf