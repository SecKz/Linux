#!/bin/sh
# Centos安装masscan
# masscan --regress		测试是否安装成功
# masscan -p20-8000 120.25.246.177 --rate=10000		扫描IP
# masscan -p80,8000-60100 10.0.0.0/8 --rate=10000   扫描网段

cd /root
yum install git gcc make libpcap-dev
git clone https://github.com/robertdavidgraham/masscan
cd masscan
make

ln -vsf /root/masscan/bin/masscan /usr/bin
