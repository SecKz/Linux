::goto很单纯，直接go to 到了某地方，而call则有点调用的意味，调用了，还要返回。所以， goto 和call的德行还是有区别的。

@echo off
title 窗口标题
color 0A

call :label
echo 1
echo 2

:label
echo 3
echo 4
