#!/bin/sh
# centos安装，若有/home/html目录，请先备份。
#mkfs -t ext3 /dev/sdb1; mount /dev/sdb1 /home; echo '/dev/sdb1               /home                   ext4    defaults        1 2' >> /etc/fstab
# http://dev.mysql.com/downloads/repo/yum/
# /usr/sbin/ntpdate -u pool.ntp.org && /sbin/hwclock -w

. "/root/centos/fun.sh"

if [ $(id -u) != "0" ]; then
    red "Error: You must be root to run this script."
    exit 1
fi

green '查看已安装WEB环境'
rpm -q php php-fpm mysql nginx httpd pure-ftpd redis memcache memcached

if [ "$1" = 'un' ]; then
	read -p "是否卸载httpd,php,mysql pure-ftpd nginx [y] " uninstall
	if [ "$uninstall" = 'y' ]; then
		green "开始卸载httpd,php,mysql pure-ftpd nginx redis------------------------------"
		service mysqld stop;
		service nginx stop;
		service pure-ftpd stop;
		service php-fpm stop;
		service redis stop;
		service memcached stop;
		yum remove "php*" mysql "httpd*" pure-ftpd nginx "redis*" "memcache*"
		rm -rf /var/log/mysqld.log /var/log/mysqld.log.rpmsave /etc/php.ini.rpmsave /etc/my.cnf.rpmsave
		rm -rf /etc/nginx /etc/pure-ftpd
		cp -a /var/lib/mysql /root
	fi
	exit;
fi

issue='/etc/issue.net'
if [ ! -f "$issue" ]; then
	red '${issue}不存在'
	exit;
fi

iscent=$(egrep -io 'centos' $issue)

if [ -z "$iscent" ]; then
	red '你的操作系统不是CentOS'
	exit;
fi

version=$(grep -Eo 'release [0-9]' $issue | cut -d' ' -f2)
bit=$(getconf LONG_BIT)
purple "你的CentOS版本是${version}, ${bit}位"


read -p "是否退出 [Y/N] " answer
if [ "$answer" = 'y' -o "$answer" = 'Y' ]; then
	exit
fi


cd /root
if [ ! -f '1.bashrc' ]; then
	mv .bashrc 1.bashrc &> /dev/null
	cp centos/0.bashrc .bashrc
	chmod 0644 /root/.bashrc
	source /root/.bashrc
fi

check_disk


setenforce 0
sed -i 's/^SELINUX=.*$/SELINUX=disabled/' /etc/selinux/config
chmod +x /root/centos/*.sh

which wget &> /dev/null || yum install wget
which curl &> /dev/null || yum install curl


id www &> /dev/null
if [ $? != 0 ]; then
	yellow "添加www用户"
	useradd -s /sbin/nologin www
	[ -d '/home/www/' ] || mkdir /home/www/
	chmod 755 /home/www
	rm -f /home/www/.bash*
fi

cd /etc/yum.repos.d/

####################################

read -p "是否安装epel和remi源 [Y/N] " inyums
read -p "是否更新yum源 [Y/N] " upyum
read -p "是否安装组件 [Y/N] " inapps

if [ "$inyums" = 'y' -o "$inyums" = 'Y' ]; then

	if [ ! -f 'epel.repo' ]; then
		yum install epel-release
	else
		green "epel.repo已安装";
	fi

	if [ ! -f 'remi.repo' ]; then
		rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-${version}.rpm
	else
		green "remi.repo已安装";
	fi

	# https://dev.mysql.com/downloads/repo/yum/
	if [ ! -f 'mysql-community.repo' ]; then
		rpm -Uvh http://repo.mysql.com/mysql57-community-release-el${version}-11.noarch.rpm
	else
		green "mysql-community.repo已安装";
	fi
fi

if [ "$upyum" = 'y' -o "$upyum" = 'Y' ]; then
	yum -y update yum;
	yum -y install yum-priorities yum-fastestmirror yum-utils;
	yum clean all;
	rm -rf /var/lib/yum/history/*.sqlite;
	yum-complete-transaction --cleanup-only;
	yum makecache;
fi

if [ "$inapps" = 'y' -o "$inapps" = 'Y' ]; then
	yum install -y kernel gcc gcc-c++ glibc automake autoconf libtool make curl curl-devel ibmcrypt-devel mhash-devel libxslt-devel zlib zlib-devel glibc glibc-devel openssl openssl-devel bash wget rpm
	yum install -y net-tools psmisc rar unzip zip p7zip lsof util-linux-ng man man-pages bind-utils cronie screen mlocate iftop nethogs htop lvm2 tree sysstat mailx rsync openssh-clients openssl finger vim ntpdate iptables-services iptables pciutils python tcpdump the_silver_searcher virt-what
	#yum install jemalloc
	service crond start
	chkconfig crond on
	chkconfig iptables on
fi


purple ++-----------------------------------------------------++

#################################### 删除原来的/home/html
if [ ! -d /home/html ]; then
	green "创建目录/home/html"
	mkdir -p /home/html
	cd /home/html
	cp /root/centos/01pinfo.php .
	cp /root/centos/ocp22.php .
	unzip /root/centos/phpmyadmin.zip -d . > /dev/null
	mv phpmyadmin pan113
	chown -R www.www /home/html
	find /home/html -type f -exec chmod 644 {} \;
	mkdir 0aa
	cd 0aa
	cp ../01pinfo.php .
	echo 123 > test.html;
fi

if [ "${version}" -gt 6 -a ! -e /root/iptables ]; then
	yellow "关闭firewall"
	systemctl stop firewalld.service		 #停止firewall
	systemctl disable firewalld.service		#禁止firewall开机启动
	firewall-cmd --state

	yellow "启动iptables"
	systemctl start iptables.service
	systemctl enable iptables.service
fi

IP=`curl -s ipv4.icanhazip.com`
[ -z "$IP" ] && IP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
mysql_root_password=$(egrep '^pwd=.+' /root/centos/dber.sh | cut -d= -f2)

Memtatol=`free -m | grep 'Mem:' | awk '{print $2}'`
Swap=`free -m | awk '/Swap:/{print $2}'`
cups=$(cat /proc/cpuinfo | grep "processor" | wc -l)

green "CPU个数是 $cups"
green "交换分区大小是 $Swap"
[ -f '/root/centos/memory.sh' ] && /root/centos/memory.sh

purple ++-----------------------------------------------------++

sshport=$(grep -Eo '^Port\s+([0-9])+' /etc/ssh/sshd_config | grep -Eo '[0-9]+');
[ -n "$sshport" ] || sshport=22
green "当前ssh端口是 $sshport"


if [ -f '/etc/sysconfig/iptables' -a ! -e /root/iptables ]; then
	yellow "设置iptables并备份iptables文件"
	mv /etc/sysconfig/iptables /root/iptables
	mv /root/centos/iptables.txt /etc/sysconfig/iptables
	sed -i "s/tcp --dport 22 -j ACCEPT/tcp --dport $sshport -j ACCEPT/" /etc/sysconfig/iptables;

	service iptables restart
	\cp /etc/passwd /root
	\cp /etc/fstab	/root

fi

read -p "是否更改ssh端口号，若更改请输入新的端口号 [Y/N] " sshport2
sshport2=$(echo $sshport2 | grep -E '^[0-9]{2,5}$');

if [ -n "$sshport2" ]; then
	yellow "更改ssh的端口为 $sshport2";
	sed -ri '/^Port\s+[0-9]+/d' /etc/ssh/sshd_config;
	echo "Port	$sshport2" >>  /etc/ssh/sshd_config
	sed -i "s/tcp --dport $sshport -j ACCEPT/tcp --dport $sshport2 -j ACCEPT/" /etc/sysconfig/iptables;
	service sshd restart
	service iptables restart
	iptables -nL
fi

read -p "是否配置rsync [Y/N] " rsyncyn
read -p "是否安装mysql [Y/N] " mysqlyn
read -p "是否安装pure-ftpd [Y/N] " ftpyn
read -p "是否安装nginx [Y/N] " nginxyn

yellow "1. php-5.3"
yellow "2. php-5.6"
yellow "3. php-7"
read -p "请选择要安装的php-fpm版本:" PHP_version

case $PHP_version in
	1)
		arepo=base
		;;
	2)
		arepo=remi-php56
		;;
	3)
		arepo=remi-php71
		;;
	*)
		#arepo=0
		;;
esac

read -p "是否安装redis [Y/N] " redisyn
read -p "是否安装memcached [Y/N] " memcachedyn
read -p "是否优化sysctl.conf [Y/N] " sysanswer


##################################### rsync
if [ "$rsyncyn" = 'y' -o "$rsyncyn" = 'Y' ]; then
	rpm -q rsync || yum install -y rsync
	grep -q '^rsync --daemon' /etc/rc.local || echo "rsync --daemon" >> /etc/rc.local
	if [ $? = 0 ]; then
		\cp -a /root/centos/rsyncd.conf /etc
		killall rsync 2> /dev/null;
		rsync --daemon
		grep -q '/root/centos/rsync.sh' /var/spool/cron/root &> /dev/null || echo '0 2 * * * /root/centos/rsync.sh' >> /var/spool/cron/root
		rpass=$(</dev/urandom tr -dc A-Za-z0-9 | head -c30)
		echo "backer:$rpass" > /etc/rsyncd.pass
		chmod 600 /etc/rsyncd.pass
		chown root.root /etc/rsyncd.pass
	else
		red 'rsync未安装'
	fi
fi



##################################### mysql

if [ "$mysqlyn" = 'y' -o "$mysqlyn" = 'Y' ]; then
	rpm -q mysql-community-server > /dev/null
	if [ $? != 0 ]; then
		yum install -y mysql-community-server
		if [ $? = 0 ]; then
			mysql_root_password=$(</dev/urandom tr -dc A-Za-z0-9 | head -c32)
			red "mysql root密码 $mysql_root_password"
			echo $mysql_root_password > /root/centos/mypwd.txt
			/root/centos/mysql.sh
			service mysqld start;

			mysql -uroot << EOF
			flush privileges;
			update mysql.user set authentication_string=password('$mysql_root_password'), password_expired = 'N', password_last_changed = now() where user='root';
EOF

			sed -i "s/^pwd=.*/pwd=${mysql_root_password}/" "/root/centos/dber.sh"
			sed -i "s/^pwd=.*/pwd=${mysql_root_password}/" "/root/centos/addsite.sh"
			sed -i "s/^define('DBPW'.*/define('DBPW', '${mysql_root_password}');/" "/root/centos/expuser.php"
			ln -vsf /root/centos/dber.sh /sbin
			sed -i 's/^skip-grant-tables/#skip-grant-tables/' /etc/my.cnf
			rm -f /var/lock/subsys/mysqld
			service mysqld restart
			chkconfig mysqld on;
		fi
	fi
fi

##################################### pure-ftpd

if [ "$ftpyn" = 'y' -o "$ftpyn" = 'Y' ]; then
	rpm -q pure-ftpd > /dev/null
	if [ $? != 0 ]; then
		hup="-uroot -p$mysql_root_password"
		mysql $hup -e ''
		if [ $? = 0 ]; then
			yum install -y pure-ftpd
			if [ $? = 0 ]; then
				pureftpd_password=$(</dev/urandom tr -dc A-Za-z0-9 | head -c32)
				green "pureftpd密码 $pureftpd_password"
				mysql $hup  < /root/centos/pureftpd.sql
				mysql $hup -e "grant all privileges on pureftpd.* to 'pureftpd'@'localhost' identified by '${pureftpd_password}';";
				mysql $hup -e "flush privileges;select user,host,password from mysql.user;show databases;";
				sed -i "s/^MYSQLPassword.*/MYSQLPassword	$pureftpd_password/" /root/centos/pureftpd-mysql.conf
				cd /etc/pure-ftpd
				sed -i 's/^# MySQLConfigFile/MySQLConfigFile/' pure-ftpd.conf
				mv pureftpd-mysql.conf pureftpd-mysql.conf1
				cp -a /root/centos/pureftpd-mysql.conf .
				service pure-ftpd start
				chkconfig pure-ftpd on

				#sed -i 's/^IPTABLES_MODULES=""$/IPTABLES_MODULES="ip_conntrack_netbios_ns ip_conntrack_ftp ip_nat_ftp"/' /etc/sysconfig/iptables-config


			fi
		else
			red '数据库连接错误'
		fi
	fi
fi


##################################### nginx

if [ "$nginxyn" = 'y' -o "$nginxyn" = 'Y' ]; then

	[ -f "/etc/yum.repos.d/nginx.repo" ] || cp -a /root/centos/nginx.repo /etc/yum.repos.d/
	[ -f '/etc/yum.repos.d/nginx.repo' ] && sed -i "s@\$releasever@${version}@" /etc/yum.repos.d/nginx.repo

	rpm -q nginx > /dev/null
	if [ $? != 0 ]; then
		yum install -y nginx 			# nginx-1.8.0-1.el6.ngx
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
	fi
fi

##################################### php-fpm php5.3以上支持mysqlnd

if [ -n "$arepo" ]; then
	rpm -q php-fpm > /dev/null
	if [ $? != 0 ]; then
		yum install -y php php-fpm php-gd php-xml php-mbstring php-ldap php-mcrypt php-pear php-devel php-mysqlnd php-pecl-zendopcache --enablerepo=$arepo
		rpm -q php-mysqlnd || yum install -y php-mysql --disablerepo="remi*"
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
	fi
fi


if [ "$redisyn" = 'y' -o "$redisyn" = 'Y' ]; then
	rpm -q redis > /dev/null
	if [ $? != 0 ]; then
		yum install -y redis --enablerepo=remi
		yum install -y php-pecl-redis --enablerepo=$arepo
		grep -q 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' /etc/rc.local || echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> /etc/rc.local
		grep -q '^vm.overcommit_memory = 1' /etc/sysctl.conf || echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf
		chkconfig redis on
		service redis start
		service php-fpm restart
		sysctl -p
	fi

	if [ ! -e "/home/html/prz22" ]; then
		cd /home/html
		unzip /root/centos/phpRedisAdmin.zip -d .
		mv phpRedisAdmin prz22
		chown -R www.www prz22
		find prz22 -type f | xargs -i chmod 644 {}
	fi

fi

if [ "$memcachedyn" = 'y' -o "$memcachedyn" = 'Y' ]; then
	rpm -q php memcached > /dev/null
	if [ $? != 0 ]; then
		yum install -y memcached --enablerepo=remi
		yum install -y php-pecl-memcached --enablerepo=$arepo
		chkconfig memcached on
		service memcached start
		service php-fpm restart
	fi
fi


if [ "$sysanswer" = 'y' -o "$sysanswer" = 'Y' ]; then
	cp /etc/sysctl.conf /root/sysctl.conf
	grep -q '^fs.file-max' /etc/sysctl.conf || cat >> /etc/sysctl.conf << EOF
fs.file-max=65535
net.ipv4.tcp_max_tw_buckets = 60000
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 4096 87380 4194304
net.ipv4.tcp_wmem = 4096 16384 4194304
net.ipv4.tcp_max_syn_backlog = 65536
net.core.netdev_max_backlog = 32768
net.core.somaxconn = 32768
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_fin_timeout = 20
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.ip_local_port_range = 1024 65000
net.nf_conntrack_max = 6553500
net.netfilter.nf_conntrack_max = 6553500
net.netfilter.nf_conntrack_tcp_timeout_close_wait = 60
net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 120
net.netfilter.nf_conntrack_tcp_timeout_time_wait = 120
net.netfilter.nf_conntrack_tcp_timeout_established = 3600
EOF

	sysctl -p
	if [ $? != 0  ]; then
		modprobe bridge
		grep -q '^modprobe bridge' /etc/rc.local || echo "modprobe bridge" >> /etc/rc.local
	fi
fi

myslow="/var/log/mysqlslow.log"

if [ ! -f "$myslow" ]; then
	touch $myslow
	chown mysql.mysql $myslow
	rm -f /var/lock/subsys/mysqld
	service mysqld restart
fi

if [ -f '/etc/init.d/yum-updatesd' ]; then
	service yum-updatesd stop
	chkconfig yum-updatesd off
fi

if ! grep -q '* hard nofile 65535' /etc/security/limits.conf; then
ulimit -n 65535
cat >> /etc/security/limits.conf <<EOF
* soft nproc 65535
* hard nproc 65535
* soft nofile 65535
* hard nofile 65535
EOF
fi

purple ++-----------------------------------------------------++

if [ "${version}" -gt 6 ]; then
	systemctl list-unit-files|egrep -i 'php-fpm|mysqld|pure-ftpd|nginx|crond|iptables|redis|memcache'
else
	chkconfig --list | egrep -i 'php-fpm|mysqld|pure-ftpd|nginx|crond|iptables|redis|memcache'
fi

[ -f '/usr/share/zoneinfo/Asia/Shanghai' ] && ln -svf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

red ++-----------------------------------------------------++
crontab -l
red ++-----------------------------------------------------++
echo "open files: `ulimit -n`, max user processes: `ulimit -u`"
red ++-----------------------------------------------------++
green "内存的使用率和剩余率"
free -m | grep "buffers/cache"
red ++-----------------------------------------------------++
blue "mysql root密码 $mysql_root_password"
echo "${IP}/pan113"
echo "${IP}/prz22"
echo "${IP}/01pinfo.php"

purple ++-----------------------------------------------------++
green "压力测试"
echo "ab -H 'Accept-Encoding: gzip' -n1000000 -kc10000 ${IP}/01pinfo.php"
purple ++-----------------------------------------------------++

green "检测nginx配置"
curl -A 'apachebench' -o /dev/null -s -w %{http_code}  127.0.0.1/01pinfo.php
curl -A 'java/' -o /dev/null -s -w %{http_code}  127.0.0.1/01pinfo.php
curl -o /dev/null -s -w %{http_code} -I 127.0.0.1/attachment/aa.php
curl -o /dev/null -s -w %{http_code} -I 127.0.0.1/aaaa/upload/aa.php
curl -o /dev/null -s -w %{http_code} -I 127.0.0.1/00/aa.sql
curl -o /dev/null -s -w %{http_code} -I 127.0.0.1/123.conf
echo;
purple ++-----------------------------------------------------++

yellow "nginx错误日志 /var/log/nginx/error.log"
yellow "php-fpm错误日志 /var/log/php-fpm/phperror.log"
yellow "php-fpm慢日志 /var/log/php-fpm/phpslow.log"
yellow "mysql慢日志 /var/log/mysqlslow.log"
yellow "mysql错误日志 /var/log/mysqld.log"
purple ++-----------------------------------------------------++
green "正在更新locate数据库"
updatedb
sync
purple "别忘了reboot，删除安装文件"

# curl 127.0.0.1/nginx_status; curl 127.0.0.1/phpfpm_status

# ab -H 'Accept-Encoding: gzip' -n1000000 -kc10000 ${IP}/01pinfo.php

#echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all
#echo "当前的mta是："
#alternatives --display mta

# echo 'This is a test mail!' | mail -s 'text' 260741887@qq.com

#/usr/bin/mysql_secure_installation

# Set DNS		国内服务器用223.5.5.5和114.114.114.114
#cat > /etc/resolv.conf << EOF
#nameserver 223.5.5.5
#nameserver 114.114.114.114
#nameserver 8.8.8.8
#EOF

# Set timezone
#ln -svf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# ntpdate time.nist.gov
# 0 */2 * * * root /usr/sbin/ntpdate -u pool.ntp.org && /sbin/hwclock -w

# iftop -h 			查看帮助
# iftop 			进入界面按3可按流量大小排序
# > np3

#wget -qO- bench.sh | bash
