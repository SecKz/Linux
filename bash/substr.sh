#!/bin/sh
#“#”表示从字符开始部分除去，一旦匹配则立即除去
#“##”表示从字符开始部分除去，会搜整个字符串最长的和的匹配来除去
#“%”表示从字符结束的部分除去，一旦匹配成公则立即除去
#“%%”表示从字符结束的部分开始除去，会搜寻整个字符穿中最长的匹配来除去
#“*”统配符

# ${#变量名}得到字符串长度
# ${变量名:起始:长度}得到子字符串

file="/user/work/mysql.con.doc"

basename $file|cut -d. -f1
basename $file|awk -F'.' '{print $1}'
basename $file|awk -F'.' '{print $NF}'

echo ---------------------------------------

test='I love china'
echo ${#test}
echo ${test:5}
echo ${test:5:10}

path=/root/lnmp/lnmp_install.sh
echo ${path##*/}
echo ${path%/*}
echo ${path##*.}

echo ---------------------------------------

basename /root/lnmp/lnmp_install.sh
dirname /root/lnmp/lnmp_install.sh

echo ---------------------------------------

echo ${path##*/}
echo ${path%/*}
echo ${path##*.}
