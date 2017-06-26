#!/bin/sh
#	生成文件 
cat <<'EOF' > 20-roundcube.conf
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


if [ -z "${pwd}" ]; then
  tmp=$(</dev/urandom tr -dc A-Za-z0-9 | head -c12)
  read -p "MySQL roundcube user password [${tmp}]:" pwd
  pwd=${pwd:-${tmp}}
  echo "MySQL roundcube: ${pwd}" 
fi

if [ -z "${rootpwd}" ]; then
  read -p "MySQL root password []:" rootpwd
  echo ${rootpwd:-jack}
fi