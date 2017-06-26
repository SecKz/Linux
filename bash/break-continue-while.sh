#!/bin/sh
#

kk=5
while [ $kk -lt 12 ]; do
echo $kk
kk=$((kk+1))
done

echo ---------------------------

kk=5
while [ $kk -lt 12 ]; do
kk=$((kk+1))				#放到echo $kk会死循环
if [ $kk = 9 ]; then
continue
fi
echo $kk
done

echo ---------------------------

kk=5
while [ $kk -lt 12 ]; do
if [ $kk = 9 ]; then
	break
fi
	echo $kk
	((kk+1))
done
