#!/bin/bash

read  -p "输入你要查看的服务:" service; 

service=$(chkconfig --list|awk -F'[: ]' '{print $1}'|grep ^$service$)		# 精确匹配
# service=$(chkconfig --list|awk -F'[: ]' '{print $1}'|grep $service)  # 模糊匹配

if [ ! $service ]
then
echo "服务$service不存在"
exit
fi

service $service status &> /dev/null		# 屏蔽正确和错误输出
if [ $? -eq 0 ]					# 判断上句是否执行成功
then
echo  "$service service is running."
else
echo  "$service service is 未运行."
fi