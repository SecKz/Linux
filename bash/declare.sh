#!/bin/sh
#

declare -i num   #必须声明-i, 以表示整型变量.注释这行，或不要i
num=5+5			#+前后不要有空格
echo $num
num="5+5"
echo $num
num=4*6
echo $num
echo -----------------------------------------------------------1
let i=5
let i=i+1
echo $i
let "i = i + 2"
echo $i
let "i+=1"
echo $i
echo -----------------------------------------------------------
echo $(( 2 % 5 ))
echo $(( 5+99 ))
echo $((5-99))

