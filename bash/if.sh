#!/bin/sh
# 执行sh if.sh 'a b'			#1等于一个参数

read -p '请输入变量名：' service
if [ ! $service ]; then
echo "service不存在";
else
echo "$service存在";
fi

echo 参数：$#
echo  $1，$2;
echo -----------

if [ $# = 1 -a  "$1" = 0 ]; then
echo 11 $1;
elif [ $# = 1 -a  "$1" = 1 ]; then
echo 22 $1;
elif [ $# = 2 -a  "$1" = d ]; then
echo 33 $1，$2;
fi

echo -----------------------------

name=tom
test $name != tom
echo $?      
[ $name=Tom ]
echo $?
[ $name = [Tt]?? ]  #[]和test不允许使用通配符.
echo $?
