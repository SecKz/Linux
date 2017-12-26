#!/bin/sh
# 安装Python 3.5.3
# http://www.cnblogs.com/lilidun/p/6041198.html

if [ -d "/usr/local/python35" ]; then
    echo "python3.5 has installed."
    exit 1
fi

yum groupinstall "Development tools"
yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel openssl-static

cd /root
wget --no-check-certificate https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tar.xz
tar xf Python-3.5.3.tar.xz
cd Python-3.5.3

./configure --prefix=/usr/local/python35
make -j && make install

ln -svf /usr/local/python35/bin/python3.5 /usr/bin/python3
ln -svf /usr/local/python35/bin/pip3 /usr/bin/pip3
ln -svf /usr/local/python35/bin/easy_install /usr/bin/easy_install3

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
