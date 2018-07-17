#!/bin/sh
# 安装gogs

if [ -d "/home/git/gogs" ]; then
    echo "gogs has installed."
    exit 1
fi

[ -d '/home/git/' ] || mkdir /home/git/

id git > /dev/null 2>&1

if [ $? != 0 ]; then
	echo "添加git用户"
	useradd git
	rm -f /home/git/.bash*
fi

cd /home/git

bit=$(getconf LONG_BIT)

file="https://dl.gogs.io/0.11.53/gogs_0.11.53_linux_amd64.tar.gz"

if [ "$bit" = 32 ]; then
	file = "https://dl.gogs.io/0.11.53/gogs_0.11.53_linux_386.tar.gz"
fi

bfile=$(basename $file)

[ -e $bfile ] || wget --no-check-certificate $file
tar -zxvf $bfile -C /home/git/
chown -R git.git /home/git/

iptables -nL | grep "dpt:3000"
if [ $? != 0 ]; then
	iptables -I INPUT -p tcp --dport 3000 -j ACCEPT
	service iptables save
	service iptables restart
fi

which apt-get > /dev/null 2>&1
if [ $? = 0 ]; then
	cp /home/git/gogs/scripts/init/debian/gogs /etc/init.d/
else
	cp /home/git/gogs/scripts/init/centos/gogs /etc/init.d/
fi

chmod +x /etc/init.d/gogs
service gogs start

# gogs以git用户启动 gogs默认需要git用户启动服务，先新建git用户，然后切换用户
# su - git -c "/home/git/gogs/gogs web"



