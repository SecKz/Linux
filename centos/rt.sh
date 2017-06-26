#!/bin/sh
# curl 查看一个web站点的响应时间

# time_namelookup： DNS解析时间,从请求开始到DNS解析完毕所用时间。
# time_connect ：连接时间,从开始到建立TCP连接完成所用时间,包括前边DNS解析时间，如果需要单纯的得到连接时间，用这个time_connect时间减去前边time_namelookup时间。
# time_appconnect 变量表示 SSL/SSH 握手的耗时（ssl延时）
# time_total： 总时间，按秒计。

# curl -w "@curl-format.txt" -o /dev/null -s  http://www.tmall.com
# curl -o /dev/null -s -w %{http_code}::%{time_namelookup}::%{time_connect}::%{time_starttransfer}::%{time_total}::%{speed_download}"\n" "http://www.baidu.com"

#local_ip:			%{local_ip}
#remote_ip:			%{remote_ip}
#local_port:			%{local_port}


restr="\n
http_code:			%{http_code}
size_download:			%{size_download}
speed_download:			%{speed_download}
num_connects:			%{num_connects}
size_request:			%{size_request}

--------------------------------------------------

time_namelookup:		%{time_namelookup}
time_connect:			%{time_connect}
time_appconnect:		%{time_appconnect}
time_redirect:			%{time_redirect}
time_pretransfer:		%{time_pretransfer}
time_starttransfer:		%{time_starttransfer}

--------------------------------------------------
time_total:			%{time_total}
\n"

if [ -z "$1" ]; then
echo "请输入域名(https网站需要输入https://)"
exit;
fi

#curl -w "@curl-format.txt" -o /dev/null -s  "$1"

curl -w "$restr" -o /dev/null -s  "$1"

