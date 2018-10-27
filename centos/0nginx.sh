#!/bin/sh
# service nginx stop; yum remove nginx
# /root/centos/0nginx.sh
. "/root/centos/fun.sh"

issue='/etc/redhat-release'

version=$(grep -Eo 'release [0-9]' $issue | cut -d' ' -f2)
cups=$(cat /proc/cpuinfo | grep "processor" | wc -l)
IP=`curl -s ipv4.icanhazip.com`
[[ $IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] || IP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')

[ -f "/etc/yum.repos.d/nginx.repo" ] || cp -a /root/centos/nginx.repo /etc/yum.repos.d/
[ -f '/etc/yum.repos.d/nginx.repo' ] && sed -i "s@\$releasever@${version}@" /etc/yum.repos.d/nginx.repo

rpm -q nginx > /dev/null
if [ $? != 0 ]; then
	yum install nginx 			# nginx-1.8.0-1.el6.ngx
	if [ $? = 0 ]; then
		\mv /etc/nginx/nginx.conf /root
		\cp -a /root/centos/nginx.conf /etc/nginx/
		\cp -a /root/centos/g.conf /etc/nginx/
		\cp -a /root/centos/agent_deny.conf /etc/nginx/
		sed -i "s/^# allow ip;$/allow $IP;/" /etc/nginx/nginx.conf

		green "修改nginx.conf worker_processes值为：" $cups
		sed -i "1,10s/^worker_processes.*/worker_processes  $cups;/" /etc/nginx/nginx.conf
		echo 'fastcgi_param PHP_ADMIN_VALUE "open_basedir=$document_root/:/tmp/";' >> /etc/nginx/fastcgi_params
		sed -ri 's/rotate [0-9]+$/rotate 4/' /etc/logrotate.d/nginx
		mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf1
		cp -a /root/centos/block_ip_ngx.conf /etc/nginx/
		[ -d "/var/lib/nginx/" ] && find /var/lib/nginx/ -type d -exec chmod 755 {} \;
		nginx;
		chkconfig nginx on;
	fi
else
	green "nginx已安装"
fi
