#!/bin/sh
#使用read命令存在着潜在危险。脚本很可能会停下来一直等待用户的输入。如果无论是否输入数据脚本都必须继续执行，
#那么可以使用-t选项指定一个计时器。
#-t选项指定read命令等待输入的秒数。当计时满时，read命令返回一个非零退出状态;

if read -t 5 -p "please enter your name:" name
then 
    echo "hello $name ,welcome to my script"
else
    echo "sorry,你输入太慢了, 我是一个SB, 你是一个2B."
fi
exit 0