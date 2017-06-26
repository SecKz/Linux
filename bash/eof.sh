#!/bin/sh
# eof中引用外部变量


cat << EOF 
+--------------------------------------------------------------+ 
| === Welcome to Tunoff services === | 
+--------------------------------------------------------------+ 
如何在编写SHELL显示多个信息，用EOF 
EOF 

mysql_root_password=$(</dev/urandom tr -dc A-Za-z0-9 | head -c30)

echo +--------------------------------------------------------------+ 

echo "mysql root密码 $mysql_root_password"

cat << EOF > /root/00dber.sh

host=localhost
user=root
pwd=$mysql_root_password					

[ -d "$dir" ] || mkdir -p "$dir"

EOF

chmod +x /root/00dber.sh

