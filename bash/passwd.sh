#!/bin/sh
#判断当前系统上是否有用户的默认shell为bash；
#如果有，就显示有多少个这类用户；否则，就显示没有这类用户；
GESHU=`grep "bash" /etc/passwd | wc -l`
if [ $GESHU -eq 0 ] ;
then echo "mei you zhe lei yong hu "
else 
echo " you {$GESHU}"
fi 

echo -------------------------------------------------------------------
grep "bash$" /etc/passwd &> /dev/null
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
echo '没有可登录的用户';
else
echo grep "bash$" /etc/passwd;
fi