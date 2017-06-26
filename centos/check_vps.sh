#!/bin/bash
# http://www.vpsdx.com/865.html
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH
yum install -y gcc gcc-c++ gdb
wget http://people.redhat.com/~rjones/virt-what/files/virt-what-1.12.tar.gz
tar zxvf virt-what-1.12.tar.gz
cd virt-what-1.12/
mkdir /root/virtwhat
./configure --prefix=/root/virtwhat					# --prefix=/root/virt-what
make && make install
/root/virtwhat/virt-what