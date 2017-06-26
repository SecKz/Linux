::echo %pid%|findstr   %a%不要加引号,“|”前面不要有空格
::set var=""		等号前面不要有空格
:: "%var%" 不等于 %var% 输出变量的正确方法是echo %var%
::if %pid%==""和if "%pid%"==""是有区别的

@echo off
title 窗口标题
color 0A

set var=30

echo %var%
echo "%var%"

if "%var%" == %var% (
echo 有引号和没引号都一样
) else (
echo 变量不要加引号
)

echo -----------------------------------------

set str=

echo %str%

if "%str%" == "" (
echo 999
)
