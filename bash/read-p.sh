#!/bin/sh
# read -p 后面可以跟提示语,没有p,直接跟变量名
#在read命令行中也可以不指定变量.如果不指定变量，那么read命令会将接收到的数据放置在环境变量REPLY中。
# -n 非空字符串 -z 空字符串

read -p "请输入rpm包名：" rpm
a=$(rpm -qa|grep -i "$rpm")

if [ -n "$a" ]; then			# 也可以用if [ $? == 0 ]; then判断
echo "${rpm}已安装"
echo -e "$a"					#输入换行，试改为echo $a
else 
echo "${rpm}没有安装"
fi


