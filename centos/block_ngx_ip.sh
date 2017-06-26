#!/bin/sh
#  http://www.oschina.net/code/snippet_17_8959

########################################

nginx_home="/etc/nginx"            #你的nginx配置目录
log_path="/var/log/nginx/access.log"    #你的日志路径

########################################

tail -100 ${log_path} \
|grep -i -v -E "dnspod|google|yahoo|baidu|msnbot|FeedSky|sogo" \
|awk '{print $1}' |sort |uniq -c|sort -nr|head \
|awk '{if($1>80)print "deny "$2";"}' >> ${nginx_home}/block_ip_ngx.conf

#关键变量解释
#tail -100 ${log_path} 读取日志中最近100行记录
#|grep -i -v -E "dnspod|google|yahoo|baidu|msnbot|FeedSky|sogo" 搜索引擎等蜘蛛除外
#|awk '{print $1}' |sort |uniq -c|sort -nr|head 合并重复记录，并计算数量
#|awk '{if($1>80)print "deny "$2";"}' > ${nginx_home}/safe_block_deny.conf
#多于80行的IP将在nginx配置目录生成 Nginx deny 语法的配置文件给予调用。
#以上变量大家使用的时候根据需要修改吧。
