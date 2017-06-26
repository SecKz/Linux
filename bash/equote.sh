#!/bin/sh
# equote

read -p "是否安装配置rsync: " answer

if [ "$answer" != 0 ]; then			#这行的0可以不要引号
echo '不是0';
else
echo '是0';
fi

echo -------------------

if [ "$answer" -ne "0" ]; then			#这行的0一定要引号
echo '不是0';
else
echo '是0';
fi

echo -------------------

if [ "$answer" -gt 0 ]; then
echo '大于0';
else
echo '不大于0';
fi

