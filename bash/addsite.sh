#!/bin/sh
#根据域名创建虚拟主机
# sh addsite.sh 域名 [目录名]

if [ -z "$1" ]; then
echo 请输入域名
exit;
fi

domain=$1
domain1=${domain//./}
mysqlpwd=$(</dev/urandom tr -dc A-Za-z0-9 | head -c20)
ftppwd=$(</dev/urandom tr -dc A-Za-z0-9 | head -c20)
date=$(date)
uid=$(id -u www)
mysql_root_password=poRTikj4561df3zXCSDaf
IP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')


sitehome="/home/${domain}/"
if [ $# = 2 ]; then
sitehome="/home/${2}/"
fi


if [ ! -d "$sitehome" ]; then		
echo $sitehome;
#mkdir $sitehome;
#chown -R www:www $sitehome; 
#cd $sitehome;
#echo '网站创建成功' $date > '0index.php'

else
echo "目录${sitehome}已经存在，请为网站指定一个新的目录名。";
exit;
fi

#log=/root/addsite.txt
#[ ! -f $log ] && touch $log


mysql -uroot -p$mysql_root_password  << EOF
#insert into pureftpd.ftpusers values( '$domain', MD5('$ftppwd'), '$uid', '$uid', '$sitehome', '0', '0', '0', '0', '*', '' , '1');
#create database $domain1;
#grant all privileges on $domain1.* to '$domain1'@'localhost' identified by '$mysqlpwd'";
#show grants for '$domain1'@localhost;
EOF

if [ $? -gt 0 ]; then
echo 
exit
fi

echo "
网站添加成功，目录为
$sitehome
测试页面 www.${domian}/0index.php;
mysql账号
$domain1 $domain1 $mysqlpwd
ftp账号
$IP $domain $ftppwd
";

