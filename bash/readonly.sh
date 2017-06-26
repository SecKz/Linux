#!/bin/sh
#使用readonly可以声明一个变量为只读属性。
readonly test  #声明test变量为只读
readonly -f testfunc  #声明testfunc函数为只读
readonly -a testarray  #声明testarray数组为只读
echo $test
readonly test1=$(date)
echo $test1
