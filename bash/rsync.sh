#!/bin/sh
# 文件同步
bakdir='/root/rsyncbak/'
day=3					#保留备份的天数

[ ! -d "$bakdir" ] && mkdir -p "$bakdir"

DATE=`date +%Y-%m-%d`
todir="$bakdir$DATE"

[ ! -d $todir ] && mkdir -p $todir

rsync -avzP --inplace --delete /root/test "$todir/ttt" &
rsync -avzP --inplace --delete /home/xxzhinan.com $todir &
rsync -avzP --inplace --delete /home/ezbd520.com $todir &
rsync -avzP --inplace --delete /usr/local/mysql/var/ $todir/mysql &   

find "$bakdir" -maxdepth 1 ! -mtime -$day -type d | egrep '[0-9]+-[0-9]+-[0-9]+$' |xargs -i rm -rf {}

