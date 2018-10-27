#!/bin/sh
# https://fatesinger.com/76137
# ssserver -c /etc/shadowsocks.json 启动ss服务器
# curl --socks5 127.0.0.1:41080 http://httpbin.org/ip

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
    cat > /etc/shadowsocks.json << EOF
{
	"server":"0.0.0.0",
	"server_port":49001,
	"local_address": "127.0.0.1",
	"local_port":41080,
	"password":"1230.1",
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

if [ -z `grep -q "dport 49001" /etc/sysconfig/iptables` ]; then
	iptables -I INPUT -p tcp --dport 49001 -j ACCEPT
	service iptables save;service iptables restart
fi


yum install libevent openssl-devel libsodium
pip3 install m2crypto
pip3 show m2crypto > /dev/null;[ $? != 0 ] && yum install m2crypto
pip3 install shadowsocks

ln -vsf  /usr/local/python36/bin/ssserver /usr/bin/
ln -vsf  /usr/local/python36/bin/sslocal /usr/bin/

cp /root/centos/shadowsocks.ini /etc/init.d/shadowsocks
#wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks -O /etc/init.d/shadowsocks;
chmod +x /etc/init.d/shadowsocks
service shadowsocks start
chkconfig shadowsocks on


