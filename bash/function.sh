#!/bin/sh
# 需要编写一个较庞大的脚本时，可能会涉及许多函数、变量。这是通常建议将众多的函数、变量放入一个单独的脚本内。 通过. ./function.sh
# 这样做的好处很明显，不用担心某个函数、变量是否已经被定义和使用，也不用频繁地定义、清除函数和变量。
# http://www.cnblogs.com/nufangrensheng/p/3478935.html

hello()
{
        echo "Now is the function hello."
        echo "Hello! $1."
        return 
}

function hi()
{
        echo "Now si the function hi."
        echo "Hi! $1."
        return 
}
