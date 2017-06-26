:: 管道符（|）的作用是将符号前的进程输出，当做符号后进程的输入。
:: 两条命令用管道符（|）连接就可以“查找当前文件夹中含有.txt的所有文件、文件夹”。
:: http://www.jb51.net/article/63210.htm

@echo off
title 窗口标题
color 0A

: 将当前日期放在剪贴板中。
echo %date:~,10%|clip

: 将一份当前目录列表的副本放入
dir > dir.txt