#!/bin/sh
# 浮点数比较
# http://www.cnblogs.com/breezey/p/6806385.html
# shell if 浮点数比较

if [ $(echo "3.6 <= 4"|bc) = 1 ]; then echo "ok";else echo "fail";fi

if [ $(echo "3.6 <= 5.4"|bc) = 1 ]; then
	echo "ok"
else
	echo "fail"
fi


echo "10.2>10.1" | bc
echo "10 >= 20" | bc
echo "10 >= 10" | bc
echo "10 < 20" | bc

if (( $(echo "10 >= 10" | bc) )); then
	echo "y"
else
	echo "n"
fi

if (( $(echo "10.02 <= 0.22" | bc) )); then
	echo "y"
else
	echo "n"
fi



