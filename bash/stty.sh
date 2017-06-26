#!/bin/sh
# 在输入一个字符后不用按回车就提交

# 通过按键继续
# read -n 1 -p "Press any key to continue..."

mysqlftppwd=`cat /dev/urandom | head -1 | md5sum | head -c 8`
echo "==========================="
echo "Your password of mysql ftp user was:$mysqlftppwd"
echo "==========================="


get_char()
{
SAVEDSTTY=`stty -g`
stty -echo
stty cbreak																#开启输入立即响应模式
dd if=/dev/tty bs=1 count=1 2> /dev/null
stty -raw
stty echo
stty $SAVEDSTTY
}

echo "Press any key to start install Pure-FTPd..."
char=`get_char`

echo "Start download files..."
echo $char