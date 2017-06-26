#!/bin/sh
#产生指定范围的随机数0-100

i=1

while [ $i -le 20 ]; do
echo "$RANDOM % 101 + 0" | bc
i=$((i+1))
done