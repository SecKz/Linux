#!/bin/sh
# source 引入外部文件 ,相当于php的include
source ./source-inc.sh

echo -------------------------------
echo $var
start $@;

echo -----------------------------
echo $@;
var1=$(pwd)
echo $var1
