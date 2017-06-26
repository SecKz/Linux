::bat教程

@echo off
title 窗口标题
color 0A
echo %date%
echo.
echo %time%

:从定向
echo %time% >> 0time.txt

if ERRORLEVEL 0 echo "执行成功"

echo %errorlevel%

echo %cd%
:cd d:/

echo 1 2 3
