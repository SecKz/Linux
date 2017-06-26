#!/usr/bin/expect -f
#set的变量不能用单引号，要双引号或者不用引号
# ssh远程登录到服务器,并且执行命令,执行完后并退出
#expect脚本必须以interact或expect eof结束，执行自动化任务通常expect eof就够了。

set password "15aoAGVqiaeTaJss1onp1yaxJ2aJo9ap4Jyq7Dzt"
set timeout 20
spawn ssh 218.241.10.158 -p14322
expect {
"yes/no" { send "yes\r"; exp_continue}
"password:" { send "$password\r" }
}
expect "#*"
send "pwd\r"
send  "exit\r"
expect eof
