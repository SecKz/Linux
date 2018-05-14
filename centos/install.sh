#!/bin/sh
# centos安装，若有/home/html目录，请先备份。
# mkfs -t ext3 /dev/sdb1; mount /dev/sdb1 /home; echo '/dev/sdb1               /home                   ext4    defaults        1 2' >> /etc/fstab
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
		rm -rf /var/log/mysqld.log /var/log/mysqld.log.rpmsave /etc/my.cnf.rpmsave /etc/php.ini.rpmsave
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


#################################### yum源配置

/root/centos/0yum.sh

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

curl ip.cn

IP=`curl -s ipv4.icanhazip.com`
[ -z "$IP" ] && IP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
mysql_root_password=$(egrep '^pwd=.+' /root/centos/dber.sh | cut -d= -f2)

Memtatol=`free -m | grep 'Mem:' | awk '{print $2}'`
Swap=`free -m | awk '/Swap:/{print $2}'`
cups=$(cat /proc/cpuinfo | grep "processor" | wc -l)

green "CPU个数是 $cups"
green "交换分区大小是 $Swap"
[ -f '/root/centos/memory.sh' ] && /root/centos/memory.sh

#################################### 更改ssh端口

/root/centos/0ssh_port.sh

read -p "是否配置rsync [Y/N] " rsyncyn
read -p "是否安装mysql [Y/N] " mysqlyn
read -p "是否安装pure-ftpd [Y/N] " ftpyn
read -p "是否安装nginx [Y/N] " nginxyn

yellow "1. php-5.3"
yellow "2. php-5.6"
yellow "3. php-7.2"
read -p "请选择要安装的php-fpm版本:" PHP_version

case $PHP_version in
	1)
		arepo=base
		;;
	2)
		arepo=remi-php56
		;;
	3)
		arepo=remi-php72
		;;
	*)
		arepo=remi-php71
		;;
esac

read -p "是否安装redis [Y/N] " redisyn
read -p "是否安装memcached [Y/N] " memcachedyn
read -p "是否优化sysctl.conf [Y/N] " sysanswer


##################################### php-fpm php5.3以上支持mysqlnd

if [ -n "$arepo" ]; then
	/root/centos/0php.sh $arepo
fi


##################################### nginx

if [ "$nginxyn" = 'y' -o "$nginxyn" = 'Y' ]; then
	/root/centos/0nginx.sh
fi


##################################### rsync
if [ "$rsyncyn" = 'y' -o "$rsyncyn" = 'Y' ]; then
	/root/centos/0rsync.sh
fi


##################################### mysql

if [ "$mysqlyn" = 'y' -o "$mysqlyn" = 'Y' ]; then
	/root/centos/0mysql57.sh
fi

##################################### pure-ftpd

if [ "$ftpyn" = 'y' -o "$ftpyn" = 'Y' ]; then
	/root/centos/0pureftp.sh
fi


if [ "$redisyn" = 'y' -o "$redisyn" = 'Y' ]; then

	/root/centos/0redis.sh $arepo

	if [ ! -e "/home/html/prz22" ]; then
		cd /home/html
		unzip /root/centos/phpRedisAdmin.zip -d .
		mv phpRedisAdmin prz22
		chown -R www.www prz22
		find prz22 -type f | xargs -i chmod 644 {}
	fi

fi

if [ "$memcachedyn" = 'y' -o "$memcachedyn" = 'Y' ]; then
	/root/centos/0memcache.sh $arepo
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
# ln -svf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# ntpdate time.nist.gov
# 0 */2 * * * root /usr/sbin/ntpdate -u pool.ntp.org && /sbin/hwclock -w

# iftop -h 			查看帮助
# iftop 			进入界面按3可按流量大小排序
# > np3

# wget -qO- bench.sh | bash
