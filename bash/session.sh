#!/bin/sh
# 定期清除php中产生的过期session文件
# 手动查看 sh session.sh 1

cronlog='/root/session.log'
date=$(date)

php=php
which php-fpm >/dev/null 2>&1
[ $? = 0 ] && php=php-fpm

# 找出php session的存放位置　/var/lib/php/session
sessdir=`$php -i|grep -i 'session.save_path' | awk -F';|=>' '{print $NF}'| sed 's/^ *\| *$//g'`

if [ -d "$sessdir" ]; then
num=$(find "$sessdir" -type f | wc -l)
num1=$(find "$sessdir" -atime -1 -type f | wc -l)
num2=$((num-num1))
fi

################### 手动查看session详细

if [ -d "$sessdir" -a $# = 1 -a "$1" = 1 ]; then
echo "session文件夹是$sessdir"
echo "其中共有session文件$num"
echo "一天内被访问过的session文件：$num1"
echo "其中过期session文件：$num2"
exit 0
elif [ -d "$sessdir" -a $# = 1 ] ; then
echo "${1}参数不正确"
exit 0
fi

################### 定时执行

if [ -d "$sessdir" ]; then
echo "$date" > $cronlog
echo "session文件夹是$sessdir" >> $cronlog
echo "其中共有session文件$num" >> $cronlog
echo "一天内被访问过的session文件：$num1" >> $cronlog
echo "被清除的过期session文件：$num2" >> $cronlog
find "$sessdir" ! -atime -1 -type f | xargs rm -f
else
echo "时间$date" > $cronlog
echo "$sessdir不存在" >> $cronlog
fi
exit 0




