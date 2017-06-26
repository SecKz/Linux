#!/bin/sh
# 查找子串的位置
str="abc"
expr index $str "a"  # 1
expr index $str "b"  # 2
expr index $str "x"  # 0
expr index $str ""   # 0