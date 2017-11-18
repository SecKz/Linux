#!/bin/sh
# 导出表中遇到Table is marked as crashed and should be repaired ,进到mysql控制台修复表repair table tablename;
# dber.sh 0					进入控制台
# dber.sh 1					列出全部数据库
# dber.sh t dbname			列出数据库的表
# dber.sh e dbname			导出数据库
# dber.sh e dbname table	导出数据库的表
# dber.sh i dbname db.sql	导入sql文件到已有数据库

# mysql_upgrade -uroot -p123456    # mysql升级
# CREATE DATABASE IF NOT EXISTS `bbbb` DEFAULT CHARACTER SET utf8;
# drop database if exists webauth;

# 添加root用户和修改密码
# grant all privileges on *.* to root@'%' identified by '123456' with grant option; flush privileges;
# update mysql.user set password=password('123456') where User='root';

time=`date +%Y%m%d`
dir=/root/backdb/							#备份目录
days=2										#保留几天的备份
otime=$((60*24*days-60))					#以分钟算更精确的控制，减60，防止保存3份

port=3306
host=localhost
user="root"
pwd=aJt94RLjfcP8H7lZmAHPmNG2OYP7FI

[ -d "$dir" ] || mkdir -p "$dir"

VER=$(mysql -V |awk -F"," '{ print $1}' | awk '{ print $NF}' | grep -Eo '[0-9]+.[0-9]+')

pwzd="password"
if (( $(echo "$VER >= 5.7 " | bc) )); then
	pwzd="authentication_string"
fi

hup="-h$host -u$user -p$pwd -P$port";

if [ $# = 1 -a "$1" = 0 ]; then
	mysql $hup;
elif [ $# = 1 -a "$1" = 1 ]; then
	mysql $hup -e 'show databases;'
elif [ $# = 1 -a "$1" = 'u'  ]; then								#查看数据库用户
	mysql $hup -e "select user,host,$pwzd from mysql.user;"
elif [ $# = 2 -a "$1" = 't'  ]; then								#查看数据库表
	mysql $hup -e "use $2;show tables;"
elif [ $# = 2 -a "$1" = e ]; then					#导出数据库
	mysqldump $hup $2 > ${dir}${2}-$time.sql
elif [ $# = 3 -a "$1" = e ]; then					#导出数据库的单个表
	mysqldump $hup $2 $3 > ${dir}${2}-${3}-$time.sql
elif [ $# = 3 -a "$1" = i ]; then					#导入sql文件到数据库，没有则创建数据库
	mysql $hup -e "create database IF NOT EXISTS $2;";
	mysql $hup $2 < $3;
elif [ $# = 2 -a "$1" = v ]; then					#查询配置项
	mysql $hup -e "show variables like '%$2%';"
elif [ $# = 2 -a "$1" = s ]; then					#查询服务器的状态信息
	mysql $hup -e "show global status like '%$2%';"
elif [ "$1" = p ]; then								#查询进程
	mysql $hup -e "show processlist\G;"
elif [ "$1" = pp ]; then								#查询进程
	mysql $hup -e "show processlist;"
elif [ $# = 1 ]; then
	head -10 $0 | tail -n +3 | grep '^#'
fi

[ $# -gt 0 ] && exit

dbs=""					#要备份的数据库

for db in $dbs; do
	mysqldump $hup $db | gzip > $dir$db-$time.sql.gz
done


find "$dir" ! -mmin -$otime -type f | egrep '\.(gz|sql)$' | xargs rm -f

