#!/bin/sh
#

read            #如果没有变量时, $REPLY是缺省变量.
echo I guess $REPLY keeps you busy!
read -p "Enter your job titile: "
echo I thought you might be an $REPLY.
read -a friends
echo Say hi to ${friends[2]}
echo Say hi to ${friends[$[${#friends[*]}-1]]}