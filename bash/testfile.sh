#!bin/bash
read -p "Input the filename:" filename
test -z "You must input a filename." && exit 0
#判断是否存在
test ! -e $filename && echo "The file $filename DO NOT exist." && exit 0
#判断文件名类型
test -f $filename && filetype="rugulre file"
test -d $filename && filetype="directory"
#判断文件执行权限
test -r $filename && perm="readable"
test -w $filename && perm="writable"
test -x $filename && perm="execuate"
#输出结论
echo "The file $filename is a $filetype"
echo "And the permission is: $perm"