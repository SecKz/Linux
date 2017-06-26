#!/bin/sh
#

if [ $# = 0 ]; then
echo '请输入文件名'
exit
fi

sites[((j++))]="jsyy.otvo.cn"
sites[((j++))]="jiaoyuan.otvo.cn"
sites[((j++))]="kf.5pl8.com"
sites[((j++))]="jf.guxiangcao.com"
sites[((j++))]="/fplx.html"
sites[((j++))]="/cgal.html"
sites[((j++))]="/lfcs.html"

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



