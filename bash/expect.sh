#!/usr/bin/expect -f
#set的变量不能用单引号，要双引号或者不用引号

set password "15aoAGVqiaeTaJss1onp1yaxJ2aJo9ap4Jyq7Dzt"
set timeout 20
spawn ssh 218.241.10.158 -p14322
expect {
"yes/no" { send "yes\r"; exp_continue}
"password:" { send "$password\r" }
}
interact			#交互模式,用户会停留在远程服务器上面
