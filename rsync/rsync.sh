#!/bin/sh
#0 1 * * * /root/centos/rsync.sh
bakdir='/root/back'
[ -d "$bakdir" ] || mkdir -p "$bakdir"

#把113.98.255.42的home模块备份到本机
rsync -avzP --delete --password-file=/etc/rsyncd.pass backer@113.98.255.42::home/ftp/1520 /root/42back/ &
rsync -avzP --delete --password-file=/etc/rsyncd.pass backer@113.98.255.42::home/mysql_data /root/42back/ &

#同机备份
rsync -avzP --inplace --delete /home/ "${bakdir}/home" &
rsync -avzP --inplace --delete /var/lib/mysql/ "${bakdir}/mysql" &
