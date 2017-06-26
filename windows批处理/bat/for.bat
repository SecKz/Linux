::　FOR %%variable IN (set) DO command

@echo off
title 窗口标题
color 0A


for %%i in (a,"b c",d) do echo %%i

echo -------------------------------------------------

::FOR /L %%variable IN (start,step,end) DO command
::其中，start为开始计数的初始值，step为每次递增的值，end为结束值。当end小于start时，step需要设置为负数。
for %%i in (1,2,10) do echo %%i
echo -------------------------------------------------
for /L %%i in (1,2,10) do echo %%i
