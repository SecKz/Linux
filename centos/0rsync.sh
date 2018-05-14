#!/bin/sh
# killall rsync;  rm -rf /etc/nginx /etc/rsyncd.pass
# /root/centos/0rsync.sh

. "/root/centos/fun.sh"

rpm -q rsync > /dev/null
if [ $? != 0 ]; then
	yum install rsync
	grep -q '^rsync --daemon' /etc/rc.local || echo "rsync --daemon" >> /etc/rc.local
	\cp -a /root/centos/rsyncd.conf /etc
	killall rsync 2> /dev/null;
	rsync --daemon
	grep -q '/root/centos/rsync.sh' /var/spool/cron/root &> /dev/null || echo '0 2 * * * /root/centos/rsync.sh' >> /var/spool/cron/root
	rpass=$(</dev/urandom tr -dc A-Za-z0-9 | head -c30)
	echo "backer:$rpass" > /etc/rsyncd.pass
	chmod 600 /etc/rsyncd.pass
	chown root.root /etc/rsyncd.pass
else
	green 'rsync已安装'
fi
