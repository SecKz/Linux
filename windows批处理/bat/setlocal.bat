::setlocal主要针对临时环境变量，不会影响到系统的变量环境设置，应与endlocal联用。
::在执行 SETLOCAL 之后所做的环境改动只限于批处理文件。要还原原先的设置，必须执行 ENDLOCAL。
::当批处理运行完成后环境变量PATH将会还原。

@echo off
set path
php -v
pause
echo -----------------------------------------

setlocal
set path=D:\phpStudy\php55
set path
php -v
pause
echo -----------------------------------------

endlocal
set path
