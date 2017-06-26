#!/bin/sh
#
if [ -d /etc/profile.d ]; then
for i in /etc/profile.d/*.sh; do			#/etc/profile.d/*.sh不能引号括起来
if [ -r "$i" ]; then
echo "${i}可读"
else
echo "${i}不可读"
fi
done
unset i						#试注释或取消这行
fi

echo ----------------------------------
echo i最后的值是：$i;
echo ----------------------------------


if [ "`id -u`" = 0 ]; then
echo '你是以root身份登录'
else
echo '你是以${USER}登录'
fi

echo ----------------------------------
echo 你是以$USER登录
echo "你是以$USER登录"
echo "你是以{$USER}登录"
echo "你是以${USER}登录"
