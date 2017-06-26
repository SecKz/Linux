#!/bin/sh
#0 1 * * * /root/centos/rsync.sh

bakdir='/home/backup'

[ -d "/home/www" ] && rsync -avzP --inplace --delete /home/www "${bakdir}" &
[ -d "/var/lib/mysql" ] && rsync -avzP --inplace --delete /var/lib/mysql "${bakdir}" &

[ -d "/etc/nginx" ] && rsync -avzP --inplace --delete /etc/nginx "${bakdir}" &
[ -f "/etc/my.cnf" ] && rsync -avzP --inplace --delete /etc/my.cnf "${bakdir}"
[ -f "/etc/php.ini" ] && rsync -avzP --inplace --delete /etc/php.ini "${bakdir}"
[ -f "/etc/php-fpm.conf" ] && rsync -avzP --inplace --delete /etc/php-fpm.conf "${bakdir}"

#远程备份
#rsync -avzP --delete --password-file=/etc/rsyncd.pass backer@58.64.177.241::home/www /home/qk_bak/58.64.177.241/
#rsync -avzP --delete --password-file=/etc/rsyncd.pass backer@58.64.177.228::mysql /home/qk_bak/58.64.177.228/
