#!/bin/sh
# 在命令行执行脚本时：　如./sh_arg /tmp/sess 2，则$1,$2指脚本名后面的参数
# $0表示的是脚本名 ，sh a.sh返回的是a.sh， /root/a.sh返回的是/root/a.sh
echo '$0表示的是：' $0;
echo '你输入的第1参数是：' $1;
echo '你输入的第2参数是：' $2;
echo '你输入的第3参数是：' $3;
if test "$2" = ""; then			#如果$2为空，执行这里
	echo "usage: $0 basedir depth"
	exit 1
fi

if test "$2" = "0"; then	#如果$2为0，执行这里
	echo "usage:第2个参数为0" 
	exit 0
fi

if test "$3" -a "$3" -ge "5"; then
	echo "第3个参数存在并且大于等于5" 
	exit 0
fi