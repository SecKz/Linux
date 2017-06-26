#!/bin/sh
#
if [ -z $1 ]; then
echo '请输入目录名';
exit
fi

files=`find $1 -type f`
for file in $files; do
echo ${file}
done

