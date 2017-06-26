#!/bin/sh
# ps -p pid 来判断里程时否存在　

if [ -z $1 ]; then
echo 请输入进程号
exit 1
fi

if ps -p $1 > /dev/null; then
echo 进程号${1}存在
else
echo 进程号${1}不存在
fi