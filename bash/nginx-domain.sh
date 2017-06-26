#!/bin/sh
#
if [ -z "$1" ]; then
echo '请输入域名'
exit 1
fi

cat /usr/local/nginx/conf/nginx.conf | grep -P '^[\s\t]*server_name[\s\t]' "$1"