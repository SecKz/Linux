#!/bin/sh
# -z空字符串 -n非空字符串
# -e用于判断文件是否存在，不能用于判断变量
# [ 5 -ne 5 ]  等同  [ 5 -ne "5" ]
# [ "5" = 5 ] , [ "5" = '5' ] , [ "5" == '5' ] 都一样

[ -n "$aa" ] && date
[ -z "$aa" ] && date
[ ! "$aa" ] && date
[ "5" = 5 ] && date
[ "5" = '5' ] && date
[ "5" == '5' ] && date
[ 5 -ne "5" ] && date

read -p '请输入变量名：' service

if [ -n "$service" ]; then
echo "$service不为空";
else
echo "输入为空";
fi

echo ++++++++++++++++++++++++++++++++++++++++++++++++++

if [ ! "$service" ]; then
echo "$service不存在";
else
echo "$service存在";
fi

echo ++++++++++++++++++++++++++++++++++++++++++++++++++

if [ -z "$service" ]; then
echo "没有输入";
else
echo "$service不为空";
fi

echo ++++++++++++++++++++++++++++++++++++++++++++++++++

if [ -e "$service" ]; then
echo "$service存在";
else
echo "$service不存在";
fi

