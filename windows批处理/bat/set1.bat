::set 会显示当前所有的系统环境变量
::set c 会显示所有的以c开头或C开头的变量（也即不区分大小写）；
::set var=""		等号前后不要有空格


@echo off
title set设置变量
color 0A

set cc=123
set cba=456
set CC2="eric"

set cc

echo ----------------------------------------------
set c

