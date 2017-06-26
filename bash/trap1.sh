#!/bin/sh
# 按下键盘中的 Ctrl-C 或 Ctrl-\ 组合时，trap 命令会捕捉信号，并发回一条消息
# 在本例中，我们希望终止脚本。在有些情形下可能不希望终止脚本，并且应当继续进行相应处理。
trap 'my_exit; exit' SIGINT SIGQUIT
count=0

my_exit()
{
echo "you hit Ctrl-C/Ctrl-\, now exiting.."
# cleanp commands here if any
}

while :
do
sleep 1
count=$(expr $count + 1)
echo $count
done