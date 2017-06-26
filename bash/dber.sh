#!/bin/sh
# 导出表中遇到Table is marked as crashed and should be repaired ,进到mysql控制台修复表repair table tablename;
# dber.sh 0					进入控制台
# dber.sh 1					列出全部数据库
# dber.sh dbname			列出数据库的表
# dber.sh d dbname			导出数据库
# dber.sh d dbname table	导出数据库的表
# dber.sh t dbname db.sql	导入sql文件到已有数据库

time=`date +%Y%m%d`
dir=/root/dbbak/							#备份目录
days=2										#保留几天的备份
otime=$((60*24*days-60))					#以分钟算更精确的控制，减60，防止保存3份

host=localhost
user=root
pwd=LraKzGbrWn3CaBY8						#数据库密码

[ -d "$dir" ] || mkdir -p "$dir"

hup="-h$host -u$user -p$pwd";

if [ $# = 1 -a "$1" = 0 ]; then
mysql $hup;
elif [ $# = 1 -a "$1" = 1 ]; then
mysql $hup -e 'show databases;'
elif [ $# = 2 -a "$1" = d ]; then					#导出数据库
mysqldump $hup $2 > ${dir}${2}-$time.sql
elif [ $# = 3 -a "$1" = d ]; then					#导出数据库的单个表
mysqldump $hup $2 $3 > ${dir}${2}-${3}-$time.sql
elif [ $# = 3 -a "$1" = t ]; then					#导入sql文件到已有的数据库
mysql $hup $2 < $3;
elif [ $# = 2 -a "$1" = v ]; then
mysql $hup -e "show variables like '%$2%';"
elif [ $# = 2 -a "$1" = s ]; then
mysql $hup -e "show global status like '%$2%';"
elif [ "$1" = p ]; then
mysql $hup -e "show processlist;"
elif [ $# = 1 ]; then								#查看数据库表
mysql $hup -e "use $1;show tables;"
fi

if [ $? -gt 0 ]; then
exit
fi

dbs="new_5200tv"					#要备份的数据库

for db in $dbs; do  
mysqldump $hup $db | gzip > $dir$db-$time.sql.gz
done  


find "$dir" ! -mmin -$otime -type f | egrep '\.(gz|sql)$' | xargs rm -f					

