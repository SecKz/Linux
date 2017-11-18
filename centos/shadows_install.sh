#!/bin/sh
# https://fatesinger.com/76137
# http://ss.jidingwan.cn/cms/45

# Make sure only root can run our script
rootness(){
    if [[ $EUID -ne 0 ]]; then
        echo "Error:This script must be run as root!" 1>&2
        exit 1
    fi
}

# Disable selinux
disable_selinux(){
    if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
        sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
        setenforce 0
    fi
}

config_shadowsocks(){
    cat > /etc/shadowsocks.json<<-EOF
{
    "server":"${IP}",
    "local_address": "127.0.0.1",
    "local_port":1080,
    "port_password":{
         "9001":"1230.1",
         "9002":"1230.2"
    },
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}

EOF
}

if [ ! -f '/etc/yum.repos.d/epel.repo' ]; then
	yum install epel-release
fi

IP=`curl ipv4.icanhazip.com`
rootness
disable_selinux
config_shadowsocks

if [ -z `grep "dport 9001" /etc/sysconfig/iptables` ]; then
	iptables -I INPUT -p tcp --dport 9001 -j ACCEPT
	service iptables save;service iptables restart
fi


yum install libevent openssl-devel swig libsodium
pip install gevent
pip install m2crypto
pip show m2crypto > /dev/null;[ $? != 0 ] && yum install m2crypto
pip install shadowsocks


cp /root/centos/shadowsocks.ini /etc/init.d/shadowsocks
#wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks -O /etc/init.d/shadowsocks;
chmod +x /etc/init.d/shadowsocks
service shadowsocks start
chkconfig shadowsocks on

