#!/bin/sh
# 要调用已经编写好的函数文件，可以像定制工作环境那样，将函数文件包含在脚本文件中，然后直接进行调用。
# 调用函数文件的格式为： . 文件 或者 source 文件
# 除了上面介绍的调用方式外，函数文件也可以像变量一样在命令提示符下使用。在命令提示符中调用函数文件后，就可以直接调用函数。
# 命令中执行 . ./function.sh;再set查看变量
# http://www.cnblogs.com/nufangrensheng/p/3478935.html

. ./function.sh

#call function hell
echo "Now call the function hello."
hello Jhon

#call function hi
echo "Now call the function hi."
hi Alix