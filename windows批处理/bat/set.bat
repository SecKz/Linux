::set /a 执行数学计算
::set /p 提示用户输入
::set var=""		等号前后不要有空格
:: "%var%" 不等于 %var%


::[设置变量]
::格式：set 变量名=变量值
::详细：被设定的变量以%变量名%引用

::[取消变量]
::格式：set 变量名=
::详细：取消后的变量若被引用%变量名%将为空

::[展示变量]
::格式：set 变量名
::详细：展示以变量名开头的所有变量的值

::[列出所有可用的变量]
::格式：set

::[计算器]
::格式：set /a 表达式
::示例：set /a 1+2*3 输出 7

@echo off
title 窗口标题
color 0A

set a=100
set b=1000
set /a c=a+b

echo %c%

set /a var=2 - 1
echo %var%
set /a var=2 * 2
echo %var%
set /a var=2 / 2
echo %var%
set /a var=(10+1) + (1+1)
echo %var%


set /a a=1+1,b=2+1,c=3+1
echo %a% %b% %c%

echo -----------------------------------

set var=我是值
echo %var%

if "%var%"=="我是值" echo "%date%"
if "%var%" NEQ "我是值1" echo "%time%"
