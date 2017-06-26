#!/bin/sh
# 用于产生从某个数到另外一个数之间的所有整数

seq 100   #起始默认是 1，间隔默认也是1
seq 2 10  #间隔默认是1
seq 1 3 10    #从1到10，间隔为3，结果是：1 4 7 10

find ./ -maxdepth 1 -type d | grep -v '^./$' | xargs -P 5 -I {} 7z a -tzip /tmp/{}.zip {}