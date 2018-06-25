#!/bin/sh
# /root/centos/0yum.sh

. "/root/centos/fun.sh"

issue='/etc/issue.net'

version=$(grep -Eo 'release [0-9]' $issue | cut -d' ' -f2)

read -p "是否安装epel、remi、mysql源 [Y/N] " inyums
read -p "是否更新yum源 [Y/N] " upyum
read -p "是否安装组件 [Y/N] " inapps

cd /etc/yum.repos.d/

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
	yum install -y net-tools psmisc rar unzip zip p7zip lsof util-linux-ng man man-pages bind-utils cronie screen mlocate iftop nethogs htop lvm2 tree sysstat mailx rsync openssh-clients openssl finger vim ntpdate iptables-services iptables pciutils python tcpdump virt-what iotop
	#yum install jemalloc
	service crond start
	chkconfig crond on
	chkconfig iptables on
fi