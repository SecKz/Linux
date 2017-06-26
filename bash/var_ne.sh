#!/bin/sh
# 不等于和等于的几种用法
# [ 5 -ne 5 ]  等同  [ 5 -ne "5" ]
# [ "5" = 5 ] , [ "5" = '5' ] , [ "5" == '5' ] 都一样
# [ 5 -ne 'c' ] 会报错 -ne只能用于整数判断
# != 比 -ne 更通用，推荐不等于判断用 !=


[ 5 -ne 5 ] && date
[ 5 -ne "5" ] && date
[ "$1" = 5 ] && echo '=';
[ "$1" = '5' ] && echo '=';
[ "$1" == '5' ] && echo '==';


echo '------------------------------------------'

if [ "$1" -ne 8 ]; then			#  sh var_ne.sh cc 会报错
echo '-ne8'
fi

if [ "$1" != 'cc' ]; then
echo '!='
fi


if [ "$1" = 'cc' ]; then				# 等同于if [ "$1" == 'cc' ]; then
echo '=cc'
fi

if [ "$1" == 'cc' ]; then
echo '==cc'
fi
