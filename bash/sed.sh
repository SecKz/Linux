#!/bin/sh
#

if [ -z "$1" ]; then
dir='.'
else
dir="$1"
fi

search="mugua.legoomall.com p57.legoomall.com";

for i in $search; do
echo $i
fgrep -o "$i" $dir | wc -l
done