#!/bin/sh
#	函数内的局部变量使用local声明

function foo()
{
local test=1
echo $test
}

function foo1()
{
test1=2				# foo1执行后test1变为全局变量
echo $test1
}

echo $test
echo $test1
echo -------------------------
foo
foo1
echo -------------------------
echo $test
echo $test1

