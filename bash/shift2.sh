#!/bin/sh
# shift可以删除参数
# shift默认是shift 1
if [ $# = 0 ]; then
echo 请输入5个参数
exit 1
fi
echo $*
echo $1
shift 2				# 删除前面两个参数
echo $*
echo $1
