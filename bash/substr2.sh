#!/bin/sh

#  取长度
str="abcdef"
expr length $str   # 4
echo ${#str}       # 4

basename /root/lnmp/lnmp_install.sh
dirname `pwd`

echo -------------------------------------------------------

#  选取子串

str="abcdef"
expr substr "$str" 1 3  # 从第一个位置开始取3个字符， abc
expr substr "$str" 2 5  # 从第二个位置开始取5个字符， bcdef
expr substr "$str" 4 5  # 从第四个位置开始取5个字符， def

echo ${str:2}           # 从第二个位置开始提取字符串， bcdef
echo ${str:2:3}         # 从第二个位置开始提取3个字符, bcd
echo ${str:(-6):5}        # 从倒数第二个位置向左提取字符串, abcde
echo ${str:(-4):3}      # 从倒数第二个位置向左提取6个字符, cde

echo -------------------------------------------------------

file="/user/work/example.tar.gz"
echo ${file%/*}
echo ${file##*/}
echo ${file%%.*}
echo ${file#*.}

echo -------------------------------------------------------

str="abbc,def,ghi,abcjkl"
echo ${str#a*c}     # 输出,def,ghi,abcjkl  一个井号(#) 表示从左边截取掉最短的匹配 (这里把abbc字串去掉）
echo ${str##a*c}    # 输出jkl，             两个井号(##) 表示从左边截取掉最长的匹配 (这里把abbc,def,ghi,abc字串去掉)
echo ${str#"a*c"}   # 输出abbc,def,ghi,abcjkl 因为str中没有"a*c"子串
echo ${str##"a*c"}  # 输出abbc,def,ghi,abcjkl 同理
echo ${str#*a*c*}   # 空
echo ${str#*d*f}    # 输出,ghi,abcjkl

echo ${str%a*l}     # abbc,def,ghi  一个百分号(%)表示从右边截取最短的匹配
echo ${str%%b*l}    # a             两个百分号表示(%%)表示从右边截取最长的匹配
echo ${str%a*c}     # abbc,def,ghi,abcjkl
