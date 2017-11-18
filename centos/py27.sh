#!/bin/sh
# 安装Python 2.7.13
# http://www.cnblogs.com/dudu/p/4294238.html

which python2.7 &> /dev/null
if [ $? = 0 ]; then
    echo "python2.7 has installed."
    exit 1
fi

yum groupinstall "Development tools"
yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel openssl-static

cd /root
wget --no-check-certificate https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz
tar xf Python-2.7.13.tar.xz
cd Python-2.7.13

./configure --prefix=/usr/local
make -j && make install

#ln -svf /usr/local/python27/bin/python2.7 /usr/local/bin/python
#ln -svf /usr/local/python27/bin/pip /usr/bin/pip


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

