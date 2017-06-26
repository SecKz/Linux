#!/bin/sh
# 通过读取ips.txt， 对每个host执行相同的命令

while read host pwd port; do
[ "$host" ] || continue;
[ "$port" ] || port=22;
./expect_cmd.sh $host $pwd $port "pwd;w"
done < ips.txt
