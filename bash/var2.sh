#!/bin/sh
#
read -p '请输入你的名字：' var
echo ${var:-nolan}	#如果var被赋值且非空，则替换它的值；否则，替换成nolan。

read -p '请输入var1的值：' var1
echo ${var1:=job}

read -p '请输入var2的值：' var2
echo ${var2:=now york}

