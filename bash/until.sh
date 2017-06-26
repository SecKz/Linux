#!/bin/sh
#
sum=0
i=1
until [ "$i" == "101" ]
do
sum=$(($sum + $i))
i=$(($i + 1))
done

echo "sum(1-100):" $sum