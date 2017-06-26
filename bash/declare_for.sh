#!/bin/bash
if [ $# == 2 ]; then
declare -a cores
cores=("aaa" "bbb" "ccc" "ddd" "eee" "fff" "ggg" "hhh" "iii" "kkk" "ooo" "ppp")

length=${#cores[@]}

for ((i=0; i<$length; i++))
do
echo "replicate ${cores[$i]} index ... ..."
done
else
echo "请输入参数：[ip] [port]"
fi

echo i的值最后是 $i

exit 0
