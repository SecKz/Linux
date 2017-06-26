#!/bin/bash
#printf和echo的区别,但echo默认会在行尾输出一个换行,printf不会
#printf会解析行内的\n,\t,但echo不会,只有当加-e 的时候才解析

printf "This script is a tool to install pureftpd for lnmp"
printf "This script is a tool to install pureftpd for lnmp"

printf "This script is a tool to install pureftpd for lnmp \n\n" 	# \n会转化成换行
printf 'This script is a tool to install pureftpd for lnmp \n\n' 	# \n会转化成换行
echo "This script is a tool to install pureftpd for lnmp \n\n"	
echo 'This script is a tool to install pureftpd for lnmp \n\n'
echo -e 'This script is a tool to install pureftpd for lnmp'
