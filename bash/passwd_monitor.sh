#!/bin/bash
#监视/etc/passwd正常
#http://www.cnblogs.com/brucee/p/3892483.html

#找出有UID 0的用户
echo "----------------------------------"
user1=`less /etc/passwd | awk -F: '$3==0 {print $1}'`
if [ -z $user1 ];then 
echo "1.there is no user's UID equals 0"
else
echo -n "1.the user of UID equals 0 have: "$user1
echo ""
fi

#找出有重复UID的用户
echo "----------------------------------"
user2=`awk -F: 'BEGIN{ORS=","}NR==FNR {a[$3]++} NR>FNR&&a[$3]>1 {print $1,$3}' /etc/passwd /etc/passwd`
if [ -z $user2 ];then 
echo "2.there is no user's UID repeat"
else
echo -n "2.the user of repeat UID have: "$user2
echo ""
fi

#找出有重复登录名的用户
echo "---------------------------------"
user3=`awk -F: 'BEGIN{ORS=","}NR==FNR {a[$1]++} NR>FNR&&a[$1]>1 {print $1,$3}' /etc/passwd /etc/passwd`
if [ -z $user3 ];then 
echo "3.there is no user's login name repeat"
else
echo -n "3.the user of repeat login name have: "$user3
echo ""
fi

#找出没有口令的所有用户
echo "---------------------------------"
user4=`sudo awk -F: 'BEGIN{ORS=","} length($2)<30 {print $1}' /etc/shadow`
if [ -z $user4 ];then 
echo "4.there is no user have no password"
else
echo -n "4.the user of no password have: "$user4
echo ""
fi

#找出没有作废日期的所有用户
echo "---------------------------------"
user5=`sudo awk -F: 'BEGIN{ORS=","} length($7)<1 {print $1}' /etc/shadow`
if [ -z $user5 ];then 
echo "5.there is no user have no outdate time"
else
echo -n "5.the user of no outdate time have: "$user5
echo ""
fi
echo "---------------------------------"