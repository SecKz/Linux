#!/bin/sh
#网站数据备份
bakdir='/root/back'
[ -d "$bakdir" ] || mkdir -p "$bakdir"
rsync -avzP --inplace --delete /home/ "${bakdir}/home" &
rsync -avzP --inplace --delete /var/lib/mysql/ "${bakdir}/mysql" &


