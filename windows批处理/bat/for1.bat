:获取指定文件夹下文件名与大小并输出到文本

@echo off
title 窗口标题
color 0A


for /f "delims=" %%i in ('dir /a-d /b c:\') do (
    for %%j in ("c:\%%i") do echo %%j 的大小为 %%~zj
)
pause