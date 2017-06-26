#!/bin/sh
# (( ))和[ ]也可以运算
A=10
B=20
expr $A + $B
expr 14 % 9				#取余
expr 2 \* 3				#	*要转义	

echo $(( 2 % 5 ))
echo $[ 2 - 5 ]

echo ----------------------------

$str="123 456 789"
expr length "$str"  # 等于echo ${#str}

# expr中的expr index $string substring索引命令功能在字符串$string上找出substring中字符第一次出现的位置，
# 若找不到则expr index返回0。注意它匹配的是字符而非字符串。
expr index $USER r
expr index $USER o