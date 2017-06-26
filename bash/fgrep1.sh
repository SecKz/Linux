#!/bin/sh
#

if [ $# = 0 ]; then
echo '请输入文件名'
exit
fi

sites[((j++))]="www.syyy666.com"
sites[((j++))]="jfc.sheng-cheng.com"
sites[((j++))]="huchou.sheng-cheng.com"
sites[((j++))]="yilihei.sheng-cheng.com"
sites[((j++))]="yc.sheng-cheng.com"
sites[((j++))]="junshi.0425.com"
sites[((j++))]="yq.sheng-cheng.com"

echo ${sites[@]}
echo "------------- 数组长度：" ${#sites[@]}

for site in ${sites[*]}; do  
n=$(fgrep -o $site "$1" | wc -l)
if [ $n -gt 0 ]; then
echo $site ": " $n
s1[((k++))]=$site
fi
done  

echo "------------- 要替换的: " ${#s1[@]}	



