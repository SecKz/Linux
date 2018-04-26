#!/bin/sh
# service mysqld stop; yum remove mysql mysql-community-common; rm -rf /var/lib/mysql; rm -rf /etc/my.cnf;
# sed -i 's/^skip-grant-tables/#skip-grant-tables/' /etc/my.cnf
# yum install mysql-community-server  --enablerepo="mysql57-community"

# set global validate_password_policy=0;

. "/root/centos/fun.sh"

rpm -q mysql-community-server > /dev/null

if [ $? != 0 ]; then
	yum install mysql-community-server  --enablerepo="mysql57-community"
	if [ $? = 0 ]; then
		mysql_root_password=$(</dev/urandom tr -dc A-Za-z0-9 | head -c32)
		echo $mysql_root_password > /root/centos/myroot_pwd.txt
		tpwd=$(grep "temporary password is" /var/log/mysqld.log |awk -F": " '{ print $2}')
		/root/centos/mysql.sh
		service mysqld start;
		\cp /etc/my.cnf /root
		red "mysql root密码 $mysql_root_password"

mysql -uroot << EOF
flush privileges;
update mysql.user set authentication_string=password('$mysql_root_password'), password_expired = 'N', password_last_changed = now() where user='root';
EOF

			sed -i "s/^pwd=.*/pwd=${mysql_root_password}/" "/root/centos/dber.sh"
			sed -i "s/^pwd=.*/pwd=${mysql_root_password}/" "/root/centos/addsite.sh"
			sed -i "s/^define('DBPW'.*/define('DBPW', '${mysql_root_password}');/" "/root/centos/expuser.php"
			ln -vsf /root/centos/dber.sh /sbin
			sed -i 's/^#validate_password_policy=0/validate_password_policy=0/' /etc/my.cnf
			sed -i 's/^skip-grant-tables/#skip-grant-tables/' /etc/my.cnf
			rm -f /var/lock/subsys/mysqld
			service mysqld restart
			chkconfig mysqld on;
	fi
fi

