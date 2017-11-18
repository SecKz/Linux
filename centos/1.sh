#!/bin/sh
#

		mysql -uroot << EOF
		select user,host from mysql.user;

EOF

