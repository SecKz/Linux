#!/bin/sh
# 定期清除php中产生的过期session文件
# 手动查看 sh session.sh 1

cronlog='/root/session.log'
date=$(date)

php=php
which php-fpm >/dev/null 2>&1
[ $? = 0 ] && php=php-fpm

# 找出php session的存放位置　/var/lib/php/session
sessdir=$(grep 'session.save_path' /etc/php-fpm.conf  | cut -d= -f2| sed 's/^ *\| *$//g')

if [ ! -d "$sessdir" ]; then
echo "$sessdir不存在";
exit
fi

num=$(find "$sessdir" -type f | wc -l)
num1=$(find "$sessdir" -atime -1 -type f | wc -l)
num2=$((num-num1))

################### 手动查看session详细

if [ $# = 1 -a "$1" = 1 ]; then
echo "session文件夹 $sessdir"
echo "其中共有session文件：$num"
echo "一天内被访问过的session文件：$num1"
echo "其中过期session文件：$num2"
fi

[ $# -gt 0 ] && exit

################### 定时执行

echo "$date" > $cronlog
echo "session文件夹 $sessdir" >> $cronlog
echo "其中共有session文件$num" >> $cronlog
echo "一天内被访问过的session文件：$num1" >> $cronlog
echo "被清除的过期session文件：$num2" >> $cronlog
find "$sessdir" ! -atime -1 -type f | xargs rm -f

