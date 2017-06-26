#!/bin/sh
# FUNCNAME 函数名变量，打印该变量会输出当前的函数名称

function foo()
{
local test=1
echo $FUNCNAME
}

foo

