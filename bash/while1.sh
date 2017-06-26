#!/bin/sh
i=1
sum=0
while [ $i -le 100 ]; do
sum=$((sum+i))
i=$((i+1))
done
echo "SUM=$sum"

i=0
while (($i<10)); do
echo $i
i=$(($i+1))
done

b=$((a++));
echo $a $b;
b=$((a++));
echo $a $b;
b=$((a++));
echo $a $b;


while ((i<6)); do
echo $i;
((i++));
done

while ((i<6));do
	echo $i;
	((i++))
done

