#!/bin/bash
# 列出无效软连接并删除

PATH=/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/etc/tomcat6/bin


read -p '输入要搜索的目录:' dir

if [ ! -d "$dir" ]; then	#"$dir"要加引号
echo "$dir不是目录"
exit 1
fi

for f in $(find $dir -type l)
do
if [ ! -e "$f" ]; then
ls -l "$f"
#echo $f
fi
done
