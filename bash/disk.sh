#!/bin/sh
# 介绍一下如何通过Shell脚本和Crontab作业结合来实现对磁盘空间的监控、告警
# http://www.cnblogs.com/kerrycode/p/3415242.html


email_logfile="diskdetail.txt";

cat /dev/null > ${email_logfile};
dp=$(df -P | grep /dev | awk '{print $5}' | sed 's/%//g')

for d in $dp 
do
echo $d >> ${email_logfile}
if [ $d -gt 1 ]; then
echo $d
#exit 0;
fi
done

