#!/bin/sh

clear

if [ -z "${mysql_roundcube_password}" ]; then
  tmp=$(</dev/urandom tr -dc A-Za-z0-9 | head -c12)
  read -p "MySQL roundcube user password [${tmp}]:" mysql_roundcube_password
  mysql_roundcube_password=${mysql_roundcube_password:-${tmp}}
  echo "MySQL roundcube: ${mysql_roundcube_password}" >> .passwords
fi

if [ -z "${mysql_root_password}" ]; then
  read -p "MySQL root password []:" mysql_root_password
fi


wget -P /var/www/html http://sourceforge.net/projects/roundcubemail/files/roundcubemail/0.8.5/roundcubemail-0.8.5.tar.gz/download#
tar -C /var/www/html -zxvf /var/www/html/roundcubemail-*.tar.gz
rm -f /var/www/html/roundcubemail-*.tar.gz 
mv /var/www/html/roundcubemail-* /var/www/html/roundcube 
chown root:root -R /var/www/html/roundcube 
chmod 777 -R /var/www/html/roundcube/temp/ 
chmod 777 -R /var/www/html/roundcube/logs/

cat <<'EOF' > /etc/httpd/conf.d/20-roundcube.conf
Alias /webmail /var/www/html/roundcube

<Directory /var/www/html/roundcube>
  Options -Indexes
  AllowOverride All
</Directory>

<Directory /var/www/html/roundcube/config>
  Order Deny,Allow
  Deny from All
</Directory>

<Directory /var/www/html/roundcube/temp>
  Order Deny,Allow
  Deny from All
</Directory>

<Directory /var/www/html/roundcube/logs>
  Order Deny,Allow
  Deny from All
</Directory>
EOF

sed -e "s|mypassword|${mysql_roundcube_password}|" <<'EOF' | mysql -u root -p"${mysql_root_password}"
USE mysql;
CREATE USER 'roundcube'@'localhost' IDENTIFIED BY 'mypassword';
GRANT USAGE ON * . * TO 'roundcube'@'localhost' IDENTIFIED BY 'mypassword';
CREATE DATABASE IF NOT EXISTS `roundcube`;
GRANT ALL PRIVILEGES ON `roundcube` . * TO 'roundcube'@'localhost';
FLUSH PRIVILEGES;
EOF

mysql -u root -p"${mysql_root_password}" 'roundcube' < /var/www/html/roundcube/SQL/mysql.initial.sql

cp /var/www/html/roundcube/config/main.inc.php.dist /var/www/html/roundcube/config/main.inc.php

sed -i "s|^\(\$rcmail_config\['default_host'\] =\).*$|\1 \'localhost\';|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['smtp_server'\] =\).*$|\1 \'localhost\';|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['smtp_user'\] =\).*$|\1 \'%u\';|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['smtp_pass'\] =\).*$|\1 \'%p\';|" /var/www/html/roundcube/config/main.inc.php
#sed -i "s|^\(\$rcmail_config\['support_url'\] =\).*$|\1 \'mailto:${E}\';|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['quota_zero_as_unlimited'\] =\).*$|\1 true;|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['preview_pane'\] =\).*$|\1 true;|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['read_when_deleted'\] =\).*$|\1 false;|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['check_all_folders'\] =\).*$|\1 true;|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['display_next'\] =\).*$|\1 true;|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['top_posting'\] =\).*$|\1 true;|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['sig_above'\] =\).*$|\1 true;|" /var/www/html/roundcube/config/main.inc.php
sed -i "s|^\(\$rcmail_config\['login_lc'\] =\).*$|\1 2;|" /var/www/html/roundcube/config/main.inc.php

cp /var/www/html/roundcube/config/db.inc.php.dist /var/www/html/roundcube/config/db.inc.php

sed -i "s|^\(\$rcmail_config\['db_dsnw'\] =\).*$|\1 \'mysqli://roundcube:${mysql_roundcube_password}@localhost/roundcube\';|" /var/www/html/roundcube/config/db.inc.php

rm -rf /var/www/html/roundcube/installer

service httpd reload