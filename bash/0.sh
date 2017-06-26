#!/bin/sh
# [[]] 运算符只是[]运算符的扩充。能够支持<,>符号运算不需要转义符，它还是以字符串比较大小。里面支持逻辑运算符：|| &&
# bash的条件表达式中有三个几乎等效的符号和命令：test，[]和[[]]。通常，大家习惯用if [];then这样的形式。
# 而[[]]的出现，根据ABS所说，是为了兼容><之类的运算符。以下是比较它们性能，发现[[]]是最快的。

# [ 2 < 61 ] && echo 'ok'   会报错，在[]使用< > ，需要转义
[ 2 \< 61 ] && echo 'ok'
[[ 2 < 61 ]] && echo 'ok'

[[ "a.txt" == a* ]] && date       # 逻辑真 (pattern matching)
[[ "a.txt" =~ .*\.txt ]] && date   # 逻辑真 (regex matching)
[[ "abc" == "abc" ]] && date       # 逻辑真 (string comparision) 
[[ "11" < "2" ]] && date           # 逻辑真 (string comparision), 按ascii值比较