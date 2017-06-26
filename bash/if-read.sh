#!/bin/sh
# then后面不可加分号; ,then如果和if在同一行，前面要加分号
read -p '请输入一个整数:' NUM ; 
if [ -z $NUM ]; then
echo '你输入的是空值';
elif [ $NUM  ==  100 ] ; then
echo '刚好是100'
elif  [ $NUM  -lt  100 ] ; then
echo '小于100';
else
echo  '大于或等于100'
fi