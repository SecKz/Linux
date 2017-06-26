::IF判断
::EQU - 等于NEQ - 不等于LSS - 小于LEQ - 小于或等于GTR - 大于GEQ - 大于或等于
::if %pid%==""，%pid%不要加引号

@echo off
title if语句
color 0A

if exist "e:\mybooks\text.txt" (echo ok ) else (echo err)
if exist "if.bat" (echo 文件存在 ) else (echo 文件不存在)

if 1==1 echo aaaa
if 1 neq 2 echo bbbb

echo ----------------------------------------------------------

set num1=20
set num2=15
if %num1% gtr %num2% echo %num1%大于%num2%
if %num1% EQU %num2% echo %num1%等于%num2%
if %num1% LSS %num2% echo %num1%小于%num2%

echo ----------------------------------------------------------

set var=""

if not %var%=="" (
echo 字符串不为空
) else (
echo 字符串为空
)

:: %var%加了双引号的输出结果
echo ----------------------------------------------------------

if "%var%"=="" (
echo 字符串为空
) else (
echo 字符串不为空

)