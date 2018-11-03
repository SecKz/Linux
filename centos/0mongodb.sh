#!/bin/sh
# sed -i "s/^  bindIp: 0.0.0.0/  bindIp: 127.0.0.1/" /etc/mongod.conf
# 禁用用户验证 sed -i "s/^security/#security/" /etc/mongod.conf ; sed -ri "s/^\s+authorization/#  authorization/" /etc/mongod.conf ; service mongod restart
# 开启用户验证 sed -i "s/^#security/security/" /etc/mongod.conf ; sed -ri "s/^#\s+authorization/  authorization/" /etc/mongod.conf ; service mongod restart
# mongo --eval "db._adminCommand( {getCmdLineOpts: 1})"
# mongod -f /etc/mongod.conf
# yum remove 'mongodb-org*'

. "/root/centos/fun.sh"

[ -f "/etc/yum.repos.d/mongodb-org-3.6.repo" ] || cp -a /root/centos/mongodb-org-3.6.repo /etc/yum.repos.d/

rpm -q mongodb-org > /dev/null

if [ $? != 0 ]; then
	yum install mongodb-org
	if [ $? = 0 ]; then
		\cp -f /etc/mongod.conf /root/
		sed -i "s/^  bindIp: 127.0.0.1/  bindIp: 0.0.0.0/" /etc/mongod.conf
		service mongod start
		chkconfig mongod on
		root_password=$(</dev/urandom tr -dc A-Za-z0-9 | head -c32)

mongo << EOF
use admin
db.createUser({user:"root", pwd:"${root_password}",roles:["root"]})
EOF

		sed -i "s/^#security:/security:\n  authorization: enabled/" /etc/mongod.conf		# 开启用户验证

		echo mongodb $root_password >> /root/centos/site.txt
		service mongod restart;

		# chown -R mongod /var/lib/mongo

	fi
else
	green "mongodb已安装"
fi
