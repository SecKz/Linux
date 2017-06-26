#!/bin/sh
#

rootdir='/usr/local/apache/www/'

badstr='@eval|@preg_replace|guige|90sec'
dirs='jiankang.0425.com junshi.0425.com junshi2.0425.com junshi3.0425.com lady.0425.com'

if [ "$1" = 0 ]; then
sdir=''
else 
sdir='/d62ata'
fi

for dir in $dirs; do
dir1=${rootdir}${dir}${sdir};
echo 开始查找: "${dir1}"
if [ -d "${dir1}" ]; then
egrep -ril "$badstr" "${dir1}";
else
echo "${dir1}"不存在
fi
done


mysql_root_password=7CWJp0TehzxF1WvSgafC	

sed -e "s/badstr/${badstr}/" <<'EOF' | mysql -u root -p"${mysql_root_password}"
USE 0425_junshi;
select aid from dede_mytag where normbody REGEXP "badstr"; 
EOF


 

