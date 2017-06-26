#!/bin/sh
# if 与 [ 要有空格
if [ "$1" -gt 10 ]; then
date
else
echo $RANDOM
fi
