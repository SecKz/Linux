#!/bin/bash

echo -n "are you femail(Y/N):"
read val

case $val in
	Y|y)			# 用户输入Y或y
		echo "yes"
		;;
	N|n)			# 用户输入N或n
		echo "no"
		;;
	*)			# 其它输入
		echo "incorrect input"
		;;
esac

exit 0