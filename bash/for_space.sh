#!/bin/sh
#
set 'apple pie' pears peaches		#这里的单引号将两个单词合成一个.
for i in "$@"				
do
echo $i
done

echo -----------------------------------

set 'apple pie' pears peaches
for i in $@
do
echo $i
done

echo -----------------------------------

set 'apple pie' pears peaches
for i in $*
do
echo $i
done

echo -----------------------------------

set 'apple pie' pears peaches
for i in "$*"           #将所有参数变量视为一个
do
echo $i
done


echo -----------------------------------

dbs="yinxiangguilincom 'pureftpd glhyzscom' 163zcwcom"	
for db in $dbs; do  
echo $db;
done  
