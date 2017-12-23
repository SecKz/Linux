#!/bin/sh
#根据域名创建虚拟主机，也可以单独创建数据库用户，FTP用户，网站配置文件
# 用法 sh addsite.sh aa.com /home/aa.com/
# 添加ftp sh addsite.sh ftp用户名 FTP路径，第二个参数FTP路径没指定时，默认是/home/www/$1/
# 添加数据库用户 sh addsite.sh dbuser，第二个参数不用指定

# 添加root用户和修改密码
# grant all privileges on *.* to root@'%' identified by '123456' with grant option; flush privileges;
# update mysql.user set password=password('123456') where User='root';
# 添加普通用户
# grant all privileges on dbname.* to 'eric'@'localhost' identified by '123456';  flush privileges;


if [ -z "$1" ]; then
	echo 请输入不带www的域名
	exit;
fi

domain=$1
domain1=${domain//./}
mysqlpwd=$(</dev/urandom tr -dc A-Za-z0-9 | head -c20)
ftppwd=$(</dev/urandom tr -dc A-Za-z0-9 | head -c20)
date=$(date)
uid=$(id -u www)
pwd=HXMFS7ofUv79D72RGRl57bruoLsaPdEN
hup="-hlocalhost -uroot -p$pwd"

IP=$(python get_ipaddr.py)
[ -z "$IP" ] && IP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')

# 删除用户
if [  $# = 2 -a "$2" = r  ]; then
	echo "drop user ${domain1}@localhost; drop database ${domain1}; delete from pureftpd.ftpusers where User='${domain}' limit 1;"
	echo "rm -rf $sitehome /etc/nginx/conf.d/${domain}.conf"
	exit
fi

sitehome="/home/www/${domain}/"
[ $# = 2 ] && sitehome="${2}"

if [ -d "$sitehome" ]; then
	echo "目录${sitehome}已经存在"
fi

mysql $hup -e '';
if [ $? -ne 0 ]; then
	echo "数据库连接错误"
exit
fi

read -p "是否添加FTP [Y/N] (Default N) " ftpanswer
[ "$ftpanswer" = 'Y' ] && ftpanswer=y
if [ "$ftpanswer" = 'y' ]; then
	mysql $hup << EOF
		insert into pureftpd.ftpusers values( '$domain', MD5('$ftppwd'), '$uid', '$uid', '$sitehome', '0', '0', '0', '0', '*', '' , '1');
EOF
fi

[ $? != 0 ] && exit;

read -p "是否添加数据库和用户 [Y/N] (Default N) " dbanswer
[ "$dbanswer" = 'Y' ] && dbanswer=y
if [ "$dbanswer" = 'y' ]; then
	mysql $hup -e "create database IF NOT EXISTS $domain1;";

	mysql $hup << EOF
	grant all privileges on $domain1.* to '$domain1'@'localhost' identified by '$mysqlpwd';
EOF

fi

[ $? != 0 ] && exit;

ngx_conf="/etc/nginx/conf.d/${domain}.conf"
if [ -f $ngx_conf ]; then
echo "网站配置文件已经存在:$ngx_conf"
else
read -p "是否添加网站配置文件 [Y/N] (Default N) " siteanswer
[ "$siteanswer" = 'Y' ] && siteanswer=y
if [ "$siteanswer" = 'y' ]; then

cat << EOF > $ngx_conf
server {
	listen       80;
	server_name  www.${domain};
	index	index.html index.php index.htm;
	root   ${sitehome};
	include agent_deny.conf;
	include	g.conf;
}

server {
	listen       80;
	server_name  ${domain};
	return       301 http://www.${domain}\$request_uri;
}
EOF

nginx -s reload
fi
fi

if [ "$siteanswer" = 'y' -o "$ftpanswer" = 'y' ]; then
[ -d "$sitehome" ] || mkdir -p $sitehome;
cd $sitehome
echo '网站创建成功' $date >> '0index.php'
chown -R www:www $sitehome;
fi

echo "++---------------------------------------------------------------------++"
[ -d "$sitehome" ] && echo "网站目录			$sitehome";
[ -d "$siteanswer" ] && echo "测试页面		${domain}/0index.php"
[ "$dbanswer" = 'y' ] && echo "mysql账号		$domain1 $domain1 $mysqlpwd"
[ "$ftpanswer" = 'y' ] && echo "ftp账号		$IP $domain $ftppwd"
echo "++---------------------------------------------------------------------++"

log='/root/centos/site.txt'
[ "$dbanswer" = 'y' ] && echo "$domain1 $domain1 $mysqlpwd" >> $log
[ "$ftpanswer" = 'y' ] && echo "$IP $domain $ftppwd" >> $log
[ "$ftpanswer" = 'y' -o "$dbanswer" = 'y' ] && echo >> $log

#echo "drop user ${domain1}@localhost; drop database ${domain1}; delete from pureftpd.ftpusers where User='${domain}' limit 1;"
#echo "rm -rf $sitehome /etc/nginx/conf.d/${domain}.conf"

