#!/bin/sh
# ${#变量名}得到字符串长度 
# ${变量名:起始:长度}得到子字符串
test='I love china'
echo ${#test}
echo ${test:5}
echo ${test:5:10} 