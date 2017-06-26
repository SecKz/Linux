#!/bin/sh
# source 引入外部文件 ,相当于php的include
var=$(pwd)
start() {
echo $# ---- $@
echo "Starting $1.... "
}
echo $var
echo "这是文件$0 +-+-+-+-+-+-+-+-+-+-+-+-"
