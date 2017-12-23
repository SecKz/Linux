#!/bin/sh

mv /etc/my.cnf /root

cat > /etc/my.cnf << EOF

[mysqld]
port = 3306
socket = /var/lib/mysql/mysql.sock
datadir=/var/lib/mysql
innodb_file_per_table=1
user = mysql
symbolic-links=0

#bind-address = ::

skip-name-resolve
back_log = 300
wait_timeout = 30
interactive_timeout = 100

max_connections = 1500
max_connect_errors = 6000
open_files_limit = 65535
table_open_cache = 128
max_allowed_packet = 500M
binlog_cache_size = 1M
max_heap_table_size = 8M
tmp_table_size = 16M

read_buffer_size = 2M
read_rnd_buffer_size = 8M
sort_buffer_size = 8M
join_buffer_size = 8M
key_buffer_size = 4M

thread_cache_size = 8

query_cache_type = 1
query_cache_size = 8M
query_cache_limit = 2M

slow_query_log = 1
long_query_time = 2
slow_query_log_file = /var/log/mysqlslow.log

#lower_case_table_names = 1

character-set-server = utf8

skip-grant-tables
skip-external-locking

bulk_insert_buffer_size = 8M
myisam_sort_buffer_size = 8M
myisam_max_sort_file_size = 10G
myisam_repair_threads = 1

#server-id = 1
#log_bin = mybin
#expire_logs_days = 7

#general_log = on
#general_log_file=/var/log/query.log

log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid

#validate_password_special_char_count=0
#validate_password_mixed_case_count=0
#validate_password_number_count=0

explicit_defaults_for_timestamp = 1

EOF

touch /var/log/mysqlslow.log;
chown mysql.mysql /var/log/mysqlslow.log

touch /var/log/query.log;
chown mysql.mysql /var/log/query.log

Mem=$(free -m | grep 'Mem:' | awk '{print $2}')

sed -i "s@max_connections.*@max_connections = $((${Mem}/3))@" /etc/my.cnf

if [ ${Mem} -gt 1500 -a ${Mem} -le 2500 ]; then
    sed -i 's@^thread_cache_size.*@thread_cache_size = 16@' /etc/my.cnf
    sed -i 's@^query_cache_size.*@query_cache_size = 16M@' /etc/my.cnf
    sed -i 's@^myisam_sort_buffer_size.*@myisam_sort_buffer_size = 16M@' /etc/my.cnf
    sed -i 's@^key_buffer_size.*@key_buffer_size = 16M@' /etc/my.cnf
    sed -i 's@^innodb_buffer_pool_size.*@innodb_buffer_pool_size = 128M@' /etc/my.cnf
    sed -i 's@^tmp_table_size.*@tmp_table_size = 32M@' /etc/my.cnf
    sed -i 's@^table_open_cache.*@table_open_cache = 256@' /etc/my.cnf
elif [ ${Mem} -gt 2500 -a ${Mem} -le 3500 ]; then
    sed -i 's@^thread_cache_size.*@thread_cache_size = 32@' /etc/my.cnf
    sed -i 's@^query_cache_size.*@query_cache_size = 32M@' /etc/my.cnf
    sed -i 's@^myisam_sort_buffer_size.*@myisam_sort_buffer_size = 32M@' /etc/my.cnf
    sed -i 's@^key_buffer_size.*@key_buffer_size = 64M@' /etc/my.cnf
    sed -i 's@^innodb_buffer_pool_size.*@innodb_buffer_pool_size = 512M@' /etc/my.cnf
    sed -i 's@^tmp_table_size.*@tmp_table_size = 64M@' /etc/my.cnf
    sed -i 's@^table_open_cache.*@table_open_cache = 512@' /etc/my.cnf
elif [ ${Mem} -gt 3500 ]; then
    sed -i 's@^thread_cache_size.*@thread_cache_size = 64@' /etc/my.cnf
    sed -i 's@^query_cache_size.*@query_cache_size = 64M@' /etc/my.cnf
    sed -i 's@^myisam_sort_buffer_size.*@myisam_sort_buffer_size = 64M@' /etc/my.cnf
    sed -i 's@^key_buffer_size.*@key_buffer_size = 256M@' /etc/my.cnf
    sed -i 's@^innodb_buffer_pool_size.*@innodb_buffer_pool_size = 1024M@' /etc/my.cnf
    sed -i 's@^tmp_table_size.*@tmp_table_size = 128M@' /etc/my.cnf
    sed -i 's@^table_open_cache.*@table_open_cache = 1024@' /etc/my.cnf
fi
