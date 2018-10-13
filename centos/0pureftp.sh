#!/bin/sh
# service pure-ftpd stop; yum remove pure-ftpd;    rm -rf /etc/nginx /etc/pure-ftpd
# /root/centos/0pureftp.sh

. "/root/centos/fun.sh"

mysql_root_password=$(egrep '^pwd=.+' /root/centos/dber.sh | cut -d= -f2)

rpm -q pure-ftpd > /dev/null
if [ $? != 0 ]; then
	hup="-uroot -p$mysql_root_password"
	mysql $hup -e ''
	if [ $? = 0 ]; then
		yum install pure-ftpd
		if [ $? = 0 ]; then
			pureftpd_password=$(</dev/urandom tr -dc A-Za-z0-9 | head -c32)
			green "pureftpd密码 $pureftpd_password"
			mysql $hup  < /root/centos/pureftpd.sql
			mysql $hup -e "grant all privileges on pureftpd.* to 'pureftpd'@'localhost' identified by '${pureftpd_password}';";
			mysql $hup -e "flush privileges;select user,host,password from mysql.user;show databases;";
			sed -i "s/^MYSQLPassword.*/MYSQLPassword	$pureftpd_password/" /root/centos/pureftpd-mysql.conf
			cd /etc/pure-ftpd
			sed -i 's/^# MySQLConfigFile/MySQLConfigFile/' pure-ftpd.conf
			sed -i 's/^#-A INPUT -p tcp -m state --state NEW -m tcp --dport 21 -j ACCEPT/-A INPUT -p tcp -m state --state NEW -m tcp --dport 21 -j ACCEPT/' /etc/sysconfig/iptables
			mv pureftpd-mysql.conf pureftpd-mysql.conf1
			cp -a /root/centos/pureftpd-mysql.conf .
			service pure-ftpd start
			chkconfig pure-ftpd on

			#sed -i 's/^IPTABLES_MODULES=""$/IPTABLES_MODULES="ip_conntrack_netbios_ns ip_conntrack_ftp ip_nat_ftp"/' /etc/sysconfig/iptables-config

		fi
	else
		red '数据库连接错误'
	fi
else
	green "pure-ftp已安装"
fi
