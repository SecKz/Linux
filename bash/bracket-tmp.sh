#!/bin/sh
#在bash 脚本中，subshells (写在圆括号里的) 是一个很方便的方式来组合一些命令。一个常用的例子是临时地到另一个目录中
#多个命令以分号分隔放置()中，则会启用子shell并执行。
#例如：(mkdir testdir;cd testdir;touch testfile)

pstree -up
(cd /home;cat > abcd.txt);		
last -4
