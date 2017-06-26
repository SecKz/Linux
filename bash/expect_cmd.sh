#!/usr/bin/expect -f
#set的变量不能用单引号，要双引号或者不用引号
# 执行方法： ./expect_cmd.sh 210.209.75.182 oh4EhIJH8Fjd6VxWAS2LG938tz6YVBdkuVxB8Kq0 22 "pwd;w"

if { $argc < 4 } {
send_user "参数错误\n"
exit
}

set ipaddress [lindex $argv 0]
set password [lindex $argv 1]
set port [lindex $argv 2]
set cmd [lindex $argv 3]

set timeout 20
spawn ssh $ipaddress -p$port
expect {
"yes/no" { send "yes\r"; exp_continue}
"password:" { send "$password\r" }
}
expect "#*"
send "$cmd\r"
send  "exit\r"
expect eof