:: 管道符（|）的作用是将符号前的进程输出，当做符号后进程的输入。
:: 两条命令用管道符（|）连接就可以“查找当前文件夹中含有.txt的所有文件、文件夹”。
:: http://www.jb51.net/article/63210.htm

@echo off
title 窗口标题
color 0A

rem 在当前目录生成很漂亮的结构树
tree /f > 1.txt

rem 象DIR命令一样,不过每个下级目录文件也列出
dir /S > 2.txt

echo 正在运行的这个批处理：
echo =========================================

echo 完全路径：%0
echo 去掉引号：%~0
echo 所在分区：%~d0
echo 所处路径：%~p0
echo 文件名：%~n0
echo 扩展名：%~x0
echo 文件属性：%~a0
echo 修改时间：%~t0
echo 文件大小：%~z0
