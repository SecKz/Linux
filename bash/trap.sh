#!/bin/sh
# http://www.cnblogs.com/nufangrensheng/p/3481761.html
# 捕获系统信号
# 在重要的脚本中，应该捕获系统发出的终止信号并作出相应的动作，以免脚本终止带来不必要的损失。
# http://www.ibm.com/developerworks/cn/aix/library/au-usingtraps/

echo aaa
trap 'echo you hit Ctrl-C/Ctrl-\, now exiting..; exit' SIGINT SIGQUIT
echo bbb


count=0

while :
 do
   sleep 1
   count=$(expr $count + 1)
   echo $count
 done