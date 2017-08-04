#!/bin/sh
# * */2 * * * /root/dber.sh

time=`date +%Y%m%d%H`
dir=/root/backdb/							#备份目录
days=1										#保留几天的备份
otime=$((60*24*days-60))					#以分钟算更精确的控制，减60

port=3306
host=172.19.6.112
user=root
pwd="suneee@mysql768"
dbs="suneee_payment"					#要备份的数据库

[ -d "$dir" ] || mkdir -p "$dir"

hup="-h$host -u$user -p$pwd -P$port";

mysql $hup -e '';
if [ $? -ne 0 ]; then
	echo "数据库连接错误"
	exit
fi


for db in $dbs; do
	mysqldump $hup $db > ${dir}${db}-$time.sql
	#echo "$hup $db > ${dir}${db}-$time.sql"
done


find "$dir" ! -mmin -$otime -type f | egrep '\.(gz|sql)$' | xargs rm -f

