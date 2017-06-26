::在DOS中，有两个环境变量可以跟当前路径有关，一个是%cd%, 一个是%~dp0。
::%cd%的内容是可以被改变的，其内容为命令的执行路径或批处理文件的执行路径。
::%~dp0只可以用在批处理文件中，它是由它所在的批处理文件的目录位置决定的

@echo off


echo %cd%
echo %~dp0

echo -------------------------------------

echo this is %%cd%%  %cd%
echo this is %%~dp0 %~dp0

echo -------------------------------------

set YII_PATH=%~dp0
echo %YII_PATH%
echo "%YII_PATH%"

