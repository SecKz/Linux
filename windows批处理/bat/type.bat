::读取文件
:: %0是指批处理文件的本身

@echo off
title 打印传人的参数
color 0A

set filename=%0

type %0
