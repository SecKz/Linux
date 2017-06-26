#!/bin/sh
#shell命令，可以按照分号分割，也可以按照换行符分割。如果想一行写入多个命令，可以通过“';”分割。
#条件测试有：[[]],[],test 这几种，注意：[[]] 与变量之间用空格分开。
# then后面不可加分号; ,then如果和if在同一行，前面要加分号

read -p '请输入你的分数：' scores
if [[ $scores == 100 ]];  then
echo "满分，gooooooooooooooood!";
elif [[ $scores -gt 90 ]];  then
echo "very good!";
elif [[ $scores -gt 80 ]]; then
echo "good!";
elif [[ $scores -gt 60 ]]; then
echo "pass!";
else
echo "no pass!";
fi;