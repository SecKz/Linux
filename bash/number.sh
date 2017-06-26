#!/bin/sh
# shell判断参数是否是数字

#read -p "请输入：" str

re=$(echo "$1" | egrep '^[0-9]+$')

if [ -n "$re" ]; then
echo ${1}是数字
else
echo ${1}不是数字
fi
