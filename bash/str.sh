#!/bin/sh
#${变量-字串}  如果变量存在且有值，返回变量值，否则返回字串内容。
#${变量=字串}  如果变量存在且有值，返回变量值，否则将字串赋给变量，并返回字串内容。
#${变量?字串}  如果变量存在且有值，返回变量值，否则显示将字串作为错误信息显示，并退出script执行。
#${变量+字串}  如果变量存在且有值，返回字串内容，否则返回空值。
#去掉命令中的:，则只检测变量是否存在，不检测是否为空。
echo -------------------------------
echo ${name=nolan}
echo $name
echo ${name=eric}
echo $name

age=
echo ${age=20}

echo ${job-manager}
echo $job

echo ${city+桂林}
echo $city

echo ${hobby?girl}
echo $hobby
