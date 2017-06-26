#!/bin/bash
#设置read命令计数输入的字符。当输入的字符数目达到预定数目时，自动退出，并将输入的数据赋值给变量。
#注意是两个分号


# 通过按键继续
# read -n 1 -p "Press any key to continue..."

read -p "Press any key to continue..." var
echo $var

read -n1 -p "Do you want to continue [Y/N]? " answer
case $answer in
Y | y)
      echo -e "\n你选择的是是$answer ,continue";;
N | n)
      echo -e  '\n good bye';;
*)
     echo  -e "\nerror choice";;
esac
exit 0
