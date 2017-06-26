#!/bin/sh
# 网站，服务器监控
# 0 */5 * * * /root/jk.sh

urls="www.zclwfb.cn 58.64.177.172 58.64.177.135 58.64.177.183 218.241.10.158 www.zgyybjb.com www.lwfbw.cn www.hzkjdxxb.com"
str=''
cdate=$(date)

for url in $urls; do
curl -s -I --connect-timeout 7 -m 30 $url > /dev/null 2>&1;
if [ $? -ne 0 ]; then
str="${str}$url "
fi
done

if [ -n "$str" ]; then
#echo $str
echo "$str" | mail -s "sites is time to check!" 260741887@qq.com
fi

