#!/bin/sh
#

str="hello world"
echo ${#str}			#显示字符串长度
echo ${str:6}			#提取world
echo ${str:7:2}			#提取or
echo ${str#hello}		#删除hello
echo ${str#*lo}			#删除hello

echo ${str%world}		#删除world
echo ${str%wo*}

echo ${str//l/m}		#将所有的字符“l”替换为“m”


