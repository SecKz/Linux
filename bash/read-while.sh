#!/bin/bash
#最后，还可以使用read命令读取Linux系统上的文件。
#每次调用read命令都会读取文件中的"一行"文本。当文件没有可读的行时，read命令将以非零状态退出。
#读取文件的关键是如何将文本中的数据传送给read命令。
#最常用的方法是对文件使用cat命令并通过管道将结果直接传送给包含read命令的while命令
#while循环一次只读一行，直至读到文件末尾


while read line
do
    echo "第一行:$line"
done <passwd