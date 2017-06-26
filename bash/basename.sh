#!/bin/sh
# 获取文件的文件名和扩展名

file="/user/work/example.tar.gz"
echo ${file%/*}				 #/user/work 一个百分号(%)表示从后面删除最短的匹配
echo ${file%%.*}			#/user/work/example  两个百分号表示(%%)表示从后面删除最长的匹配
echo ${file#*.}				#tar.gz  一个井号(#) 表示从前边删除掉最短的匹配
echo ${file##*/}			#example.tar.gz 两个井号(##) 表示从前边删除掉最长的匹配

basename $file|cut -d. -f1
basename $file|awk -F'.' '{print $1}'
basename $file|awk -F'.' '{print $NF}'

echo --------------------------------------

fullfile="/user/work/example.tar.gz"


basename $fullfile
dirname $fullfile
# => example


# 在bash中可以这么写
filename=$(basename "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}"
