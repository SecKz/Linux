#!/bin/sh
#break 命令可以带一个参数，一个不带参数的break 循环只能退出最内层的循环，而break N可以退出N 层循环。
#continue 命令也可以带一个参数，一个不带参数的continue 命令只去掉本次循环的剩余代码，而continue N 将会把N 层循环剩余的代码都去掉，但是循环的次数不变。
# break 1;   跳出一层循环；
# break 2;　跳出两层循环；
# continue也可以带这个参数

arr="1 55 66 a b"
for i in $arr; do
echo $i
done

echo -------------------

for i in $arr; do
if [ $i = a ]; then
continue
fi
echo $i
done

echo -------------------

for i in $arr; do
if [ $i = a ]; then
break
fi
echo $i
done


echo -------------------

for i in $arr; do
if [ $i = a ]; then
exit
fi
echo $i
done
