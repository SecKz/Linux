#!/bin/sh
#

dirs='jiankang.0425.com junshi.0425.com junshi2.0425.com junshi3.0425.com lady.0425.com'

for dir in $dirs; do							#$dirs不要写"$dirs"
echo $dir
done

echo -----------------------------

for dir in "$dirs"; do							
echo $dir
done
