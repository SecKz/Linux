#!/bin/sh
# http://blog.maxiang.net/15-bash-array-tutorial/148/
#通过declare进行变量声明。
# 如果数组元素包含空格符，用引号括起来。

declare -a Unix=('Debian' 'Red hat' 'Suse' 'Fedora' 'Centos');
echo $Unix										#只输出第一个
echo ${Unix[@]}					# 输出数组所有元素
echo ${#Unix}					# 数组长度
echo ${#Unix}					# 数组第一个元素的长度		

echo -----------------------------------

# 输出数组指定元素的一部分
echo ${Unix[@]:3:2}
echo ${Unix[2]:0:4}

echo -----------------------------------

# 添加已经元素到数组
Unix=("${Unix[@]}" "AIX" "HP-UX")
echo ${Unix[@]}	
echo ${#Unix}					

#  删除数组元素
unset Unix[3]
echo ${Unix[3]}
echo ${Unix[@]}	

echo -----------------------------------

# 第二种数组声明方法
a[0]='hi AA'
a[1]='Red hat'
a[2]='Ubuntu'

echo ${a[1]}



