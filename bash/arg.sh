#!/bin/sh
#

date
(date)
$(date) 
echo $(date) 
echo ----------------------------------------------------;

if [ $# -lt 3 ]; then
cat<<HELP
你的参数小于3
date
(date)
$(date) 
echo $(date) 
HELP
fi

echo ----------------------------------------------------;

if [ $# -eq 3 ]; then
cat<<DD
你的参数为3
echo $1 -- $2 --$3
echo "第1参数是${1}第2参数是{$2}第3参数是($3)"
DD
fi

echo +++++++++++++++++++++++++++++++++++++++++;

if [ $# = 1 -a $1 = 'session' ]; then
echo $RANDOM
else
echo "${1}参数不正确"
fi