:修改python的path变量

@echo off

color 07

echo ----------------------------------------------------------

echo 当前path是  %path%

set py27=%path:D:\python35\Scripts\;D:\python35\;=D:\python27\Scripts\;D:\python27\;%
set py35=%path:D:\python27\Scripts\;D:\python27\;=D:\python35\Scripts\;D:\python35\;%

:先清空字符串
set input=

set /p input=请输入python的版本(27/35)：
if "%input%" neq "27" (if "%input%" neq "35" echo 只能输入27或35 & goto A)

if "%input%"=="27" (wmic ENVIRONMENT where "name='path' and username='<system>'" set VariableValue="%py27%")
if "%input%"=="35" (wmic ENVIRONMENT where "name='path' and username='<system>'" set VariableValue="%py35%")

echo ----------------------------------------------------------

echo 修改后的path是
wmic ENVIRONMENT where "name='path' and username='<system>'" get VariableValue

:A



