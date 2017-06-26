::　FOR %%variable IN (set) DO command

@echo off
title 窗口标题
color 0A


:执行以后，屏幕上会将C:盘根目录下所有以BAT、TXT为扩展名的文件显示出来（不包括隐藏文件）。

FOR %%C IN (*.TXT *.bat) DO echo %%C

