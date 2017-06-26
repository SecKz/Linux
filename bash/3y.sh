#!/bin/sh
# http://www.cnblogs.com/lottu/p/3427724.html
# shell的3元运算语法是expr && cmd1 ||cmd2


echo $((7>33 ? 60:3));
[ 7 -gt 63 ] && date || pwd
[ 7 -gt 6 ] && echo 0 ||echo 1

# 对冒号：和内置命令true
# 在某些条件判断，我们不需要做什么操作；但未了代码的完整性，我们可以在其中添加：或者true。
# 这个类似其它语言的null。暂作简单测试。这里的：等价于true。
[ 7 -lt 6 ] && : ||echo $RANDOM;

[ 7 -gt 6 ] && : || echo $RANDOM;

[ 7 -gt 6 ] && true ||echo "1"