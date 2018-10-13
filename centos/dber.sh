#!/bin/sh
# 导出表中遇到Table is marked as crashed and should be repaired ,进到mysql控制台修复表repair table tablename;
# dber.sh 0  进入控制台, dber.sh 1 列出全部数据库
# dber.sh t dbname 列出数据库的表
# dber.sh e dbname 导出数据库, dber.sh e dbname table 导出表, dber.sh e dbname table t 只导出表的数据
# dber.sh i dbname db.sql, 导入sql文件到数据库，没有则创建数据库
# dber.sh user eric database password	创建用户eric, 授权给数据库database, 密码可以不指定, dber.sh q 'drop user aaa@localhost;flush privileges;'删除用户
# dber.sh db zcx 创建数据库, dber.sh q 'drop database sports' 删除数据库
# dber.sh host root localhsot % 更改root的host为%
# dber.sh s max 查看运行状态, dber.sh v slow 查看配置信息

# CREATE DATABASE IF NOT EXISTS aa123 DEFAULT CHARACTER SET utf8;
# drop database if exists zcx;

# 添加root用户和修改密码
# grant all privileges on *.* to root@'%' identified by '123456' with grant option; flush privileges;

# 修改密码
# update mysql.user set authentication_string=password('123456') where User='root';flush privileges;
# update mysql.user set password=password('123456') where User='root' and host='localhost';

# drop user user@localhost;flush privileges;
# show grants for 'root'@localhost;

time=`date +%Y%m%d%H`						# 备份的文件名格式  +%Y%m%d%H%M
dir=/root/backdb/							# 备份目录
days=2										# 保留几天的备份
otime=$((60*24*days-60))					# 以分钟算更精确的控制，减60，防止保存3份

port=3306
host=localhost
user="root"
pwd=123456

[ -d "$dir" ] || mkdir -p "$dir"

VER=$(mysql -V |awk -F"," '{ print $1}' | awk '{ print $NF}' | grep -Eo '[0-9]+.[0-9]+')

pwzd="password"
if [ $(echo "$VER >= 5.7"|bc) = 1 ]; then
	pwzd="authentication_string"
fi

hup="-h$host -u$user -p$pwd -P$port";

if [ $# = 1 -a "$1" = 0 ]; then
	mysql $hup;
elif [ $# = 1 -a "$1" = 1 ]; then
	mysql $hup -e 'show databases;'

elif [ $# = 2 -a "$1" = 'db' ]; then								#   创建数据库  删除数据库 dber.sh q 'drop database sports'
	mysql $hup -e "create database IF NOT EXISTS $2;";

elif [ $# = 1 -a "$1" = 'u'  ]; then								#	查看数据库用户
	mysql $hup -e "select user,host,$pwzd from mysql.user;"

elif [ "$1" = 'user' -a $# -gt 2  ]; then								#	创建用户 dber.sh user aaa database password
	mysqlpwd=$(</dev/urandom tr -dc A-Za-z0-9 | head -c20)
	[ -n "$4" ] && mysqlpwd=$4
	mysql $hup -e "grant all privileges on $3.* to '$2'@'localhost' identified by '$mysqlpwd';flush privileges;"
	echo "$2 $3 $mysqlpwd" >> /root/centos/site.txt

elif [ $# = 2 -a "$1" = 'drop' ]; then								#   删除用户  dber.sh q 'drop user aaa@localhost;flush privileges;'
	mysql $hup -e "drop user $2@localhost;flush privileges;"

elif [ $# = 4 -a "$1" = 'host' ]; then								#   更新root的host dber.sh host root localhsot %
	mysql $hup -e "update mysql.user set host='$4' where User='$2' and host='$3' limit 1;flush privileges;"

elif [ $# = 2 -a "$1" = 'q'  ]; then								# 执行sql语句
	mysql $hup -e "$2"
elif [ $# = 2 -a "$1" = 't'  ]; then								# 查看数据库表
	mysql $hup -e "use $2;show tables;"

elif [ $# = 2 -a "$1" = e ]; then					# 导出数据库
	mysqldump $hup $2 > ${dir}${2}-$time.sql
elif [ $# = 3 -a "$1" = e ]; then					# 导出数据库的单个表
	mysqldump $hup $2 $3 > ${dir}${2}-${3}-$time.sql
elif [ $# = 4 -a "$1" = e ]; then					# 导出表数据，不包括表结构
	mysqldump $hup -t $2 $3 > ${dir}${2}-${3}-$time.sql

elif [ $# = 3 -a "$1" = i ]; then					# 导入sql文件到数据库，没有则创建数据库
	mysql $hup -e "create database IF NOT EXISTS $2;";
	mysql $hup $2 < $3;

elif [ $# = 2 -a "$1" = v ]; then					# 查询配置项
	mysql $hup -e "show variables like '%$2%';"
elif [ $# = 2 -a "$1" = s ]; then					# 查询服务器的状态信息
	mysql $hup -e "show global status like '%$2%';"

elif [ "$1" = pg ]; then								#查询进程
	mysql $hup -e "show processlist\G;"
elif [ "$1" = p ]; then
	mysql $hup -e "show processlist;"
elif [ "$1" = pf ]; then
	mysql $hup -e "show full processlist;"

elif [ $# = 0 -o "$1" = h ]; then
	head -30 $0 | grep '^# dber'
fi

[ $# = 0 -o "$1" != 'bak' ] && exit

dbs="zcx gogs"					# 要备份的数据库


for db in $dbs; do
	mysqldump $hup $db | gzip > $dir$db-$time.sql.gz
	#mysqldump $hup $db > $dir$db-$time.sql
done


find "$dir" ! -mmin -$otime -type f | egrep '\.(gz|sql)$' | xargs rm -f

