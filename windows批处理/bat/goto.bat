::就需要引入流程跳转的概念，动用流程跳转语句 goto 了。流程跳转的含义是：改变默认的执行顺序，强制跳转到指定的位置执行特定的程序块。
::http://www.jb51.net/article/18980.htm

@echo off
color 0A
set /p input=请输入字母A或B：
if "%input%"=="A" goto A
if "%input%"=="B" goto B
pause
exit

:A
echo 您输入的字母是A


:B
echo 您输入的字母是B

echo %date%
