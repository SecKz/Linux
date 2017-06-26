#!/bin/sh
# $@ $*　全部参数

if [ $# = 0 ]; then
echo 请输入5个参数
exit 1
fi

echo 参数数量是 $#
echo $@
echo $*

echo $1 -- $2 --$3
shift		#删除第1个参数
echo $1 -- $2 --$3

shift		#删除第2个参数

echo $1 -- $2 --$3
echo $@
echo $*