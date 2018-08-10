#!/bin/sh
# service php-fpm stop; yum remove "php*"
# /root/centos/0php.sh remi-php72
# yum install php-zip  --enablerepo="remi-php72"

. "/root/centos/fun.sh"

if [ -z "$1" ]; then
	yellow "请指定remi对应php版本的repo"
	php -v
	ls -l /etc/yum.repos.d/
	exit
fi

rpm -q php-fpm > /dev/null
if [ $? != 0 ]; then
	yum install php php-fpm php-gd php-xml php-zip php-bcmath php-mbstring php-ldap php-mcrypt php-pear php-devel php-mysqlnd php-pecl-zendopcache --enablerepo=$1
	rpm -q php-mysqlnd || yum install php-mysql --disablerepo="remi*"
	if [ -f '/etc/php.ini' ]; then
		\cp /etc/php.ini /root
		\cp /etc/php-fpm.d/www.conf /root
		sed -i 's/^;date\.timezone =/date.timezone = Asia\/Shanghai/' /etc/php.ini
		sed -i 's/^expose_php = On/expose_php = Off/' /etc/php.ini
		sed -ri 's/^upload_max_filesize = [0-9]+M/upload_max_filesize = 10M/' /etc/php.ini
		sed -ri 's/^post_max_size = [0-9]+M/post_max_size = 10M/' /etc/php.ini
		sed -ri 's/^error_reporting = .+/error_reporting = E_ALL ^ E_NOTICE/' /etc/php.ini
		sed -ri 's/^display_errors = Off/display_errors = On/' /etc/php.ini
		[ -f '/root/centos/php-fpm.sh' ] && /root/centos/php-fpm.sh
		[ -d '/var/lib/php/session' ] && chown -R www.www /var/lib/php/session
		service php-fpm start;
		chkconfig php-fpm on;
	fi
else
	green "php已安装"
fi