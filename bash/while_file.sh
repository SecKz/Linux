#!/bin/sh
# while read line ,为什么不输出最后一行 因为你最后一行没有'\n'
while read line; do
echo $line
done < "/etc/passwd"