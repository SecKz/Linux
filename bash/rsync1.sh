#!/bin/sh
# 数据库,网站文件备份
bakdir='/bak/210.56.57.111/'
log='/root/bak.log'
day=3					#保留备份的天数
t0=$(date "+%Y-%m-%d %H:%M:%S")

[ ! -f "$log" ] && touch $log

if [ ! -d "$bakdir" ]; then
mkdir -p "$bakdir"
fi

lines=$(wc -l "$log"|awk '{print $1}')
if [ $lines -gt 50 ]; then
sed -i '1,100d' $log
fi

DATE=`date +%Y-%m-%d`
todir="$bakdir$DATE"

[ ! -d $todir ] && mkdir -p $todir

rsync -avzP --delete --password-file=/usr/local/etc/web_bak.pas web_bak@210.56.57.111::web_bak/bbs.5200tv.com "$todir/apache" &
rsync -avzP --delete --password-file=/usr/local/etc/web_bak.pas web_bak@210.56.57.111::web_bak/www.5200tv.com "$todir/apache" &
rsync -avzP --delete --password-file=/usr/local/etc/web_bak.pas web_bak@210.56.57.111::mysql_bak "${todir}/mysql" &


find "$bakdir" -maxdepth 1 ! -mtime -$day -type d | egrep '[0-9]+-[0-9]+-[0-9]+$' |xargs -i rm -rf {}

t1=$(date "+%Y-%m-%d %H:%M:%S")
echo "$0 $t0至$t1 " $todir >> $log

