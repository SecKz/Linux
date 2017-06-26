:: ”&“的作用不过是链接多条命令，而”&&“是为了判断符号前的命令是否执行成功，从而决定是否执行符号后的命令。
:: http://www.jb51.net/article/63210.htm


@echo off
title 窗口标题
color 0A

echo hello && echo world
echo aa & echo bb

C:\Users\helloworld\Desktop>start "" "111.txt" & echo hello

echo -------------------------------------------------------

0time22.txt>start "" "111.txt" && echo hello

echo -------------------------------------------------------

C:\Users\helloworld\Desktop>start "" "111.txt" || echo hello

