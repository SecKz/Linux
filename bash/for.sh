#!/bin/sh
#双引用可以防止字符串分割，在双引号里所有的字符看做是一个整体


for i in "4 5 6 7 8 9"; do		#只输出一行"4 5 6 7 8 9"
echo $i
done

echo ----------------------

num="4 5 6 7 8 9"
for i in $num; do			  #逐个输出
echo $i
done

echo ----------------------

for i in $( seq 1 7 ); do
echo $i
done

echo ----------------------

for a in "$List"; do   # Preserves whitespace in a single variable.  
echo "$a"  
done  

sum=0

echo ----------------------
for((i=1; i<=100; i++))
do
    sum=$(($sum + $i))
    i=$(($i + 1))
done
echo "sum(1--100):" $sum