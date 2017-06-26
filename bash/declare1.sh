#!/bin/sh
#通过declare进行变量声明。
# 如果数组元素包含空格符，用引号括起来。

declare -a Unix=('Debian' 'Red hat' 'Red hat' 'Suse' 'Fedora');
echo $Unix										#只输出第一个
echo ${Unix[@]}

declare -i test1								 #定义一个整型变量
declare -r test2='hello nolan'					#定义一个只读变量
test1=abc
echo $test1
echo $test2
test2=123										#这行报错 readonly variable
echo $test2

