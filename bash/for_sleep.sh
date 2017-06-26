#!/bin/sh
#

foo () 
{
date
return 0		# 改为1
}  

for i in 1 2 3 ; do
if foo; then		# 如果函数foo返回0时执行 ,取反用if ! foo; then  不要输出可以改为if foo > /dev/null; then
echo -n '.'
sleep 1
else
break
fi
done

if ! foo; then
echo zzzzzzzzz
fi
