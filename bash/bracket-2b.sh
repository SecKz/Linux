#!/bin/sh
# 在bash中，数字的比较最好使用 (( ))
# 使用 (( )) 时，不需要空格分隔各值和运算符，使用 [[ ]] 时需要用空格分隔各值和运算符。
# 诸如 [ 2 \< 10 ]、[[ 2 < 10 ]] 都是不要使用。使用算术扩展最好用 (( 99+1 == 100 )) ，而不要使用[[ 99+1 -eq 100 ]]
num=100;
total=0;
 
for((i=0;i<=num;i++));
do
    ((total+=i));
done
echo $total;
 
total=0;
i=0;
while((i<=num));
do
    ((total+=i,i++));
done
echo $total;
 
if((total>=5050));then
    echo "ok";
fi