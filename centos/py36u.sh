#!/bin/sh
# ubuntu 安装Python 3.6
# http://www.cnblogs.com/lilidun/p/6041198.html
#! /usr/bin/python3 -Es

# buntu14.04上安装python3.6
# 使用这些命令安装就行，如果没有add-apt-repository命令。先安装 apt-get install software-properties-common
#  add-apt-repository ppa:jonathonf/python-3.6
#  apt-get update
#  apt-get install python3.6


cd /root
[ -e "Python-3.6.4.tar.xz" ] || wget --no-check-certificate https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
[ -d "Python-3.6.4" ] && rm -rf "Python-3.6.4"
tar xf Python-3.6.4.tar.xz
cd Python-3.6.4

./configure --prefix=/usr/local/python36
make && make install

ln -svf /usr/local/python36/bin/python3.6 /usr/bin/python3
ln -svf /usr/local/python36/bin/pip3 /usr/bin/pip3
ln -svf /usr/local/python36/bin/easy_install /usr/bin/easy_install3

python3 -m ensurepip
python3 -m pip install --upgrade pip
pip3 install --upgrade setuptools

pip3 install wheel
pip3 install requests
pip3 install psutil
pip3 install lxml
pip3 install beautifulsoup4
pip3 install gevent
pip3 install virtualenv
pip3 install pillow
pip3 install pymysql
pip3 install pandas
