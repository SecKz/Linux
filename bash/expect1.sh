#!/usr/bin/expect -f
#set的变量不能用单引号，要双引号或者不用引号
# 执行方法： expect autosu.sh 或 ./autosu.sh 用户名 密码 端口

if { $argc < 2 } {
send_user "参数错误\n"
exit
}

set port 22

if { $argc == 3 } {
set port [lindex $argv 2]
}

set ipaddress [lindex $argv 0]
set password [lindex $argv 1]

set timeout 20
spawn ssh $ipaddress -p$port
expect {
"yes/no" { send "yes\r"; exp_continue}
"password:" { send "$password\r" }
}
interact
