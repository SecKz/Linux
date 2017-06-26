#!/bin/sh
# 批量将文件GB2312转成UTF-8
if [ -z $1 ]; then
echo '请输入目录名';
exit
fi

files=`find $1 -type f`
for file in $files; do
tmpfile=${file}.itmp
iconv -f "gbk" -t "utf-8" < $file > $tmpfile
if [ "$?" = 0 ]; then
mv $tmpfile $file
else
rm -f "$tmpfile"
fi
done


