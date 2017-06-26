#!/bin/sh
# http://www.cnblogs.com/iforever/p/4459857.html
# 使用while分段读取
# a.txt的格式
#12 tf 23
#13 米勒 24
#14 西安电子科技大学 90
#15 西安交大 90
#16 北京大学 90

cat a.txt | while read id name age
do
echo "${id}, ${name}, ${age};"
done