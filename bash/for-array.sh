#!/bin/sh
# bash定义数组的方式


sites[((j++))]="www.syyy666.com"
sites[((j++))]="jfc.sheng-cheng.com"
sites[((j++))]="huchou.sheng-cheng.com"
sites[((j++))]="yilihei.sheng-cheng.com"
sites[((j++))]="yc.sheng-cheng.com"
sites[((j++))]="yq.sheng-cheng.com"

echo ${sites[@]}						#输出全部数组
echo "数组长度是：" ${#sites[@]}

for((i=1; i<=5; i++))
do
arr[((k++))]=$RANDOM
done

echo ${arr[@]}	
echo "数组长度是：" ${#arr[@]}
