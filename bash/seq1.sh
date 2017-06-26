#!/bin/sh
# 用于产生从某个数到另外一个数之间的所有整数
# 相当于touch test{1..500000}.txt

if [ $# = 1 ]; then
echo 'rm -----------------------------'
time rm -rf /root/cc;
echo 'find ---------------------------'
time find /root/dd -delete
echo 'rsync --------------------------'
[ ! -d /root/blanktest/ ] && mkdir -p /root/blanktest/
time rsync -a --delete /root/blanktest/ /root/ee
exit
fi


if [ -d cc ]; then
exit
else
mkdir cc
fi


for i in $(seq 1 100000); do
echo test >> ~/cc/$i.txt
done;

cp -a cc dd
cp -a cc ee

ls cc |wc -l
ls dd |wc -l
ls ee |wc -l


