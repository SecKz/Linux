#!/bin/sh
#awk内置字符串函数详解

STR="mydoc.txt"
echo $STR | awk '{print substr($STR, 1, 5)}'

# 设置文件名为一变量,管道输出到awk,只返回其扩展名。
STR="mydoc.txt"
echo $STR | awk '{print substr($STR, 7)}'