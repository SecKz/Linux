#!/bin/sh
# service redis stop; yum remove "redis*"
# /root/centos/0redis.sh remi-php72

. "/root/centos/fun.sh"

if [ -z "$1" ]; then
	yellow "请指定remi对应php版本的repo"
	php -v
	ls -l /etc/yum.repos.d/
	exit
fi

rpm -q redis > /dev/null
if [ $? != 0 ]; then
	yum install redis --enablerepo=remi
	yum install php-pecl-redis --enablerepo=$1
	grep -q 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' /etc/rc.local || echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> /etc/rc.local
	grep -q '^vm.overcommit_memory = 1' /etc/sysctl.conf || echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf
	chkconfig redis on
	service redis start
	service php-fpm restart
	sysctl -p
else
	green "redis已安装"
fi
