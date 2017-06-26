#!/bin/sh
# set -e：如果命令失败（即返回一个非零的退出状态），那么脚本将退出

set -e													# 试取消这行
proj_dir=/opt/rollout/v12

cp $proj_dir/go_sup /usr/local/bin/go_sup
if [ $? != 0 ]
then
echo "could not copy $proj_dir/go_sup to /usr/local/bin/"
exit 1
fi