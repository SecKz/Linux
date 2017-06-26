#!/bin/sh
# 字符串删除
# ${变量名#substring正则表达式}从字符串开头开始配备substring,删除匹配上的表达式。
# ${变量名%substring正则表达式}从字符串结尾开始配备substring,删除匹配上的表达式。
# 注意：${test##*/},${test%/*} 分别是得到文件名，或者目录地址最简单方法。

IPTABLES=iptables;
echo ${IPTABLES%tables}		# ip

test='c:/windows/boot.ini'
echo ${test#/}		# c:/windows/boot.ini	从前面最小删除
echo ${test#*/}		# windows/boot.ini	
echo ${test##*/}	# boot.ini	从前面最大删除
echo ${test%/*}		# c:/windows	从后面最小删除
echo ${test%%/*}	# c:	从后面最大删除
read -p "请输入你的域名: " domain
echo ${domain/./+}
echo ${domain/./}
echo ${domain//./}