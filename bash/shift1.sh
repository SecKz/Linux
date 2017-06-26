#!/bin/sh
# shift可以删除参数
# shift默认是shift 1
if [ $# = 0 ]; then
echo 请输入至少5个参数
exit 1
fi

until [ -z "$1" ]  # Until all parameters used up
do
  echo "$@ "
  shift
done