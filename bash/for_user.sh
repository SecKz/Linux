#!/bin/sh
#  获得用户的满足条件的文件数

DIR="/home"
LMT=2
ValidUsers=`grep "/bin/bash" /etc/passwd | cut -d ":" -f 1`  #获得使用bash作为登录shell的用户名列表

for UserName  in  $ValidUsers; do
    Num=`find $DIR -user $UserName | wc -l`
    if  [  $Num  -gt  $LMT  ]  ;  then
         echo "$UserName have $Num files."
    fi
done 

