#!/bin/sh
#
while :
do
	echo
	echo 'Please select a version of the PHP:'
	echo -e "\t\033[32m1\033[0m. Install php-5.3"
	echo -e "\t\033[32m2\033[0m. Install php-5.4"
	echo -e "\t\033[32m3\033[0m. Install php-5.5"
	echo -e "\t\033[32m4\033[0m. Install php-5.6"
	read -p "Please input a number:(Default 1 press Enter) " PHP_version
	[ -z "$PHP_version" ] && PHP_version=1
	if [ $PHP_version != 1 -a $PHP_version != 2 -a $PHP_version != 3 -a $PHP_version != 4 ];then
		echo -e "\033[31minput error! Please only input number 1,2,3,4 \033[0m"
	else
		break
	fi
done

echo $PHP_version