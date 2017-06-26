#!/bin/sh
#${变量:-字串}  如果变量存在且有值，返回变量值，否则返回字串内容。
#${变量:=字串}  如果变量存在且有值，返回变量值，否则将字串赋给变量，并返回字串内容。
#${变量:?字串}  如果变量存在且有值，返回变量值，否则显示将字串作为错误信息显示，并退出script执行。
#${变量:+字串}  如果变量存在且有值，返回字串内容，否则返回空值。
echo --------------------------------------------------------------
apachectl=/usr/sbin/apachectl
httpd=${HTTPD-/usr/sbin/httpd}
pidfile=${PIDFILE-/var/run/httpd.pid}

echo $httpd
echo $HTTPD
echo $pidfile
echo $PIDFILE
echo --------------------------------------------------------------
LOCKFILE=
lockfile=${LOCKFILE-/var/lock/subsys/httpd}
echo $lockfile
echo --------------------------------------------------------------
LOCKFILE1=				#变量存在但为空
lockfile1=${LOCKFILE1:-/var/lock/subsys/httpd}
echo $lockfile1
echo --------------------------------------------------------------
read -p "请输入你的密码:" pw
echo ${pw-123456789}
echo --------------------------------------------------------------
read -p "请输入你的密码:" pw1
echo ${pw1:-123456789}