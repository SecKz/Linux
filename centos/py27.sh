#!/bin/sh
# 安装Python 2.7.14
# http://www.cnblogs.com/dudu/p/4294238.html

which python2.7 &> /dev/null
if [ $? = 0 ]; then
    echo "python2.7 has installed."
    exit 1
fi

yum groupinstall "Development tools"
yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel openssl-static

cd /root
[ -e "Python-2.7.14.tar.xz" ] || wget --no-check-certificate https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz
[ -d "Python-2.7.14" ] && rm -rf "Python-2.7.14"
tar xf Python-2.7.14.tar.xz
cd Python-2.7.14

./configure --prefix=/usr/local
make && make install



# 安装pip
python -m ensurepip
python -m pip install --upgrade pip
pip install --upgrade setuptools

pip install wheel
pip install requests
pip install psutil
pip install lxml
pip install beautifulsoup4
pip install virtualenv
pip3 install pillow
pip3 install pymysql
