#!/bin/sh
#
a="hello world"
echo "Hi, $as"
echo "Hi, ${a}s"

#每行不得多于255个字节，可在行末加上反斜杠的方式拆分单行内容到多行中。
test1=abcdefg\
hij\
klmnopq\
rstuvwxyz
echo $test1