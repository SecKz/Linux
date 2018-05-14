#!/bin/sh
# service memcached stop; yum remove "memcached"
# /root/centos/0memcache.sh remi-php72

. "/root/centos/fun.sh"

if [ -z "$1" ]; then
	yellow "请指定remi对应php版本的repo"
	php -v
	ls -l /etc/yum.repos.d/
	exit
fi

rpm -q php memcached > /dev/null
if [ $? != 0 ]; then
	yum install -y memcached --enablerepo=remi
	yum install -y php-pecl-memcached --enablerepo=$1
	chkconfig memcached on
	service memcached start
	service php-fpm restart
else
	green "memcached已安装"
fi
