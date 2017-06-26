#!/bin/sh
# * 任意字符。
# ? 任意单字符。
# [..] 类或范围中任意字符

echo "please input number 1 to 3"
read number
case $number in
	1)
		echo "you input 1"
		;;
	2)
		echo "you input 2"
		;;
	3|4|5)
		echo "you input 3-5之间的数字"
		;;
	*)
		echo "error! the number you input isn't 1 to 5"
		;;
esac