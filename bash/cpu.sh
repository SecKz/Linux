#!/bin/sh
#Linux查看CPU个数/多核/多线程的查看

#查看CPU型号
cat /proc/cpuinfo | grep 'model name'

#逻辑CPU个数
echo "logical CPU number:"
cat /proc/cpuinfo | grep "processor" | wc -l
 
#物理CPU个数：
echo "physical CPU number:"
cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l
 
#每个物理CPU中Core的个数：
echo "core number in a physical CPU:"
cat /proc/cpuinfo | grep "cpu cores" | uniq | awk -F: '{print $2}'
 
#查看每个physical cpu上core id的数量,即为每个物理CPU上的core的个数
cat /proc/cpuinfo | grep "core id"
 
#是否为超线程？
#如果有两个逻辑CPU core具有相同的”core id”，那么超线程是打开的。
# 当然也可知直接查询 /proc/cpuinfo 中的 "ht"这个flag
cat /proc/cpuinfo | grep flags | grep ht
 
#每个物理CPU中逻辑CPU(可能是core, threads或both)的个数：
cat /proc/cpuinfo | grep "siblings"

