#!/bin/sh
# 判断命令是否存在

command=php-fpm
which $command >/dev/null 2>&1

if [ $? = 0 ]; then
echo ${command}存在
else
echo ${command}不存在
fi