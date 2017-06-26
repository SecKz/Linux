#!/usr/bin/expect -f
#set的变量不能用单引号，要双引号或者不用引号


if { $argc < 3 } {
send_user "参数错误\n"
exit
}

set ipaddress [lindex $argv 0]
set password [lindex $argv 1]
set port [lindex $argv 2]

set timeout 20
spawn scp /root/.ssh/authorized_keys root@$ipaddress:/root/.ssh/
expect {
"yes/no" { send "yes\r"; exp_continue}
"password:" { send "$password\r" }
}
expect "100%"
expect eof