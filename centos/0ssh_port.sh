#!/bin/sh
# /root/centos/0ssh_port.sh

. "/root/centos/fun.sh"

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