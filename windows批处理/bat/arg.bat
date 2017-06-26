::批处理文件中可引用的参数为%0~%9
:: %0是指批处理文件的本身
::
@echo off
title 打印传人的参数


echo 文件名是：%0
set filename=%0
echo %filename%

:: %1%==""  %1为空时会报错，加双引号防止报错

if "%1%"=="" (
echo 输入的参数为空
) else (
echo 你输入的第一个参数是：%1
echo 你输入的第全部参数是：%*
)
