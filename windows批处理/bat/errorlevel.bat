::EQU - 等于NEQ - 不等于LSS - 小于LEQ - 小于或等于GTR - 大于GEQ - 大于或等于
@echo off
color 0A

echo 123456 | findstr "77"
echo %ERRORLEVEL%

echo 6789 | findstr "9"
echo %ERRORLEVEL%

if %ERRORLEVEL% == 0 (
echo 找到字符串
) else (
echo 没有找到字符串
)

::当使用if errorlevel 值 cmmand 句式时，它的含义是：如果返回的错误码值大于或等于值 的时候，将执行cmmand

IF errorlevel 0 echo 成功拷贝文件
IF errorlevel 1 echo 文件拷贝失败



echo -----------------------------


