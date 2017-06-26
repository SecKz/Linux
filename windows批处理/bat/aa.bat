::bat教程

@echo off
title 窗口标题
color 0A
echo %date%
echo.
echo %time%

set aa=伟大的中国！我为你自豪！
echo 替换前：%aa%
echo 替换后：%aa:中国=中华人民共和国%
echo aa = %aa%
set "aa=%aa:中国=中华人民共和国%"
echo aa = %aa%

set %path%


set bb=('wmic ENVIRONMENT where "name='path'" get VariableValue')

set %bb%
