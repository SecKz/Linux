::预定义的变量
@echo off
title 预定义的变量
color 0A

echo %CD% - 扩展到当前目录字符串。
echo %DATE% - 用跟 DATE 命令同样的格式扩展到当前日期。
echo %TIME% - 用跟 TIME 命令同样的格式扩展到当前时间。
echo %RANDOM% - 扩展到 0 和 32767 之间的任意十进制数字。
echo %ERRORLEVEL% - 扩展到当前 ERRORLEVEL 数值。
echo %CMDEXTVERSION% - 扩展到当前命令处理器扩展名版本号。
echo %CMDCMDLINE%