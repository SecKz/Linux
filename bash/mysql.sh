#!/bin/sh
# 在shell执行大段sql代码

mysql_roundcube_password=123456987
mysql_root_password=7CWJp0TehzxF1WvSgafC	


cat <<'EOF' | mysql -u root -p"${mysql_root_password}"
USE mysql;
select host,user,password from user; 
EOF

exit;

sed -e "s|mypassword|${mysql_roundcube_password}|" <<'EOF' | mysql -u root -p"${mysql_root_password}"
USE mysql;
CREATE USER 'roundcube'@'localhost' IDENTIFIED BY 'mypassword';
GRANT USAGE ON * . * TO 'roundcube'@'localhost' IDENTIFIED BY 'mypassword';
CREATE DATABASE IF NOT EXISTS `roundcube`;
GRANT ALL PRIVILEGES ON `roundcube` . * TO 'roundcube'@'localhost';
FLUSH PRIVILEGES;
EOF


# 导入sql语句
mysql -u root -p"${mysql_root_password}" 'roundcube' < ./mysql.initial.sql

