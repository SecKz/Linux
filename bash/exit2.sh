#!/bin/sh
# exit n，不执行以后的代码


read -p "请输入rpm包名：" rpm
rpm -qa|grep -i "$rpm" > /dev/null

if [ $? = 0 ]; then
echo '${rpm}已经安装'
else 
echo '${rpm}没有安装'
fi


read -p "请输入3个数字：" a b c

if [ "$a" = 10 ]; then
echo "a 等于 10"
exit 0
fi


if [ "$b" -gt 10 ]; then
echo "b 大于 10"
exit 1
fi

if [ "$c" -lt 10 ]; then
echo "c 小于 10"
exit 2
fi

echo -------------------------


