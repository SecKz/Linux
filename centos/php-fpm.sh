#!/bin/sh
#

mv /etc/php-fpm.conf /root

cat > /etc/php-fpm.conf << EOF

;include=/etc/php-fpm.d/*.conf

[global]
pid = /var/run/php-fpm/php-fpm.pid
error_log = /var/log/php-fpm/error.log
log_level = warning

emergency_restart_threshold = 30
emergency_restart_interval = 60s
process_control_timeout = 5s
daemonize = yes

[www]
listen = 127.0.0.1:9000
listen.allowed_clients = 127.0.0.1
user = www
group = www

pm = dynamic
pm.max_children = 20
pm.start_servers = 8
pm.min_spare_servers = 6
pm.max_spare_servers = 12

pm.max_requests = 2048
request_terminate_timeout = 120
rlimit_files = 51200
rlimit_core = 0

request_slowlog_timeout = 2s
slowlog = /var/log/php-fpm/phpslow.log
pm.status_path = /phpfpm_status


php_admin_value[error_log] = /var/log/php-fpm/phperror.log
php_admin_flag[log_errors] = on
php_value[session.save_handler] = files
php_value[session.save_path] = /var/lib/php/session
php_value[soap.wsdl_cache_dir]  = /var/lib/php/wsdlcache

;env[TEMP] = /tmp

EOF

touch /var/log/php-fpm/phperror.log

Mem=$(free -m | grep 'Mem:' | awk '{print $2}')

if [ $Mem -le 3000 ]; then
  sed -i "s@^pm.max_children.*@pm.max_children = $(($Mem/3/20))@" /etc/php-fpm.conf
  sed -i "s@^pm.start_servers.*@pm.start_servers = $(($Mem/3/30))@" /etc/php-fpm.conf
  sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = $(($Mem/3/40))@" /etc/php-fpm.conf
  sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = $(($Mem/3/20))@" /etc/php-fpm.conf
elif [ $Mem -gt 3000 -a $Mem -le 4500 ]; then
  sed -i "s@^pm.max_children.*@pm.max_children = 50@" /etc/php-fpm.conf
  sed -i "s@^pm.start_servers.*@pm.start_servers = 30@" /etc/php-fpm.conf
  sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = 20@" /etc/php-fpm.conf
  sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = 50@" /etc/php-fpm.conf
elif [ $Mem -gt 4500 -a $Mem -le 6500 ]; then
  sed -i "s@^pm.max_children.*@pm.max_children = 60@" /etc/php-fpm.conf
  sed -i "s@^pm.start_servers.*@pm.start_servers = 40@" /etc/php-fpm.conf
  sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = 30@" /etc/php-fpm.conf
  sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = 60@" /etc/php-fpm.conf
elif [ $Mem -gt 6500 -a $Mem -le 8500 ]; then
  sed -i "s@^pm.max_children.*@pm.max_children = 70@" /etc/php-fpm.conf
  sed -i "s@^pm.start_servers.*@pm.start_servers = 50@" /etc/php-fpm.conf
  sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = 40@" /etc/php-fpm.conf
  sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = 70@" /etc/php-fpm.conf
elif [ $Mem -gt 8500 ]; then
  sed -i "s@^pm.max_children.*@pm.max_children = 80@" /etc/php-fpm.conf
  sed -i "s@^pm.start_servers.*@pm.start_servers = 60@" /etc/php-fpm.conf
  sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = 50@" /etc/php-fpm.conf
  sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = 80@" /etc/php-fpm.conf
fi