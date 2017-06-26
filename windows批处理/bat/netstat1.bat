::纯数字用netstat查找端口，其他用tasklist模糊查找

@echo off
::color 0A
title 查找端口/pid/进程名

:whichtype

set stype=""
set /p stype=请输入要查找的端口号，字母键切换到【进程查找模式】，退出请回车：
if %stype%=="" goto end

echo %stype%|findstr /be "[0-9]*" >nul

::不是纯数字，转到tasklist查找进程
if %ERRORLEVEL% NEQ 0 (
goto task
)

echo -------------------------------------------------------------------------------
echo   协议   本地地址:端口          外部地址:端口          状态            PID
netstat -ano | findstr ".*:%stype%\>"

goto whichtype

:task

set process=""
set /p process=请输入要查找的pid或进程名关键词，返回【端口查找模式】请回车：
if %process%=="" goto whichtype

echo -------------------------------------------------------------------------------
echo	映像名称                       PID 会话名              会话#       内存使用
tasklist | findstr /I "%process%"

set pid=""
set /p pid=请输入要kill掉的pid，忽略请回车：
if %pid%=="" goto task

echo %pid%|findstr /be "[0-9]*" >nul

if %ERRORLEVEL% == 0 (
echo 正在停止进程 %pid%.......................................
taskkill -f -pid "%pid%"
)

goto whichtype

:end
exit
