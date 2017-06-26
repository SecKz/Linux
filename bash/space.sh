#!/bin/sh
#if里面的[]等号两边可以有空格，变量赋值pw = ""等号两边有空格
# var=value 			赋值操作
# var = value			判断相等操作

pw=""
read -p "请输入你的密码:" pw
if [ "$pw" = "" ]; then		#"$var"比$var更安全，因为万一$var 的值为空的话，在判断$var="yes"是就会出现错误，加上引号就不会出现这种问题了
echo "密码不能为NULL!"
exit 1
else
echo "你的密码是:$pw"
fi