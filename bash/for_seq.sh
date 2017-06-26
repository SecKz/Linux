#!/bin/sh
# seq 用于产生从某个数到另外一个数之间的所有整数

for i in $(seq 7 10); do
    echo $i;
done;

echo --------------------------------------

for i in `seq 5`;
do
echo $i
done

echo --------------------------------------

for((i=1;i<=10;i++));do
    echo $i;
done;