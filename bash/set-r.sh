#!/bin/sh
# http://www.cnblogs.com/nufangrensheng/p/3484493.html
# set命令启动受限模式 在Shell的受限模式下切换工作目录、重定向及修改环境变量等操作都被拒绝

set -r

cd /
echo "`pwd`"

echo "test" >~/test.tmp
cat ~/test.tmp

SHELL=/bin/ksh
echo "SHELL="$SHELL

