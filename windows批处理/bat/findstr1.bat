::http://www.jb51.net/article/29239.htm
::echo %pid%|findstr   %a%不要加引号,“|”前面不要有空格

@echo off
title 窗口标题
color 0A

echo 123a654|findstr /be "[0-9]*" >nul && echo 全部是数字 || echo 不是纯数字
echo %errorlevel%

echo -------------------------------------------------------------

echo abcd|findstr /I "A" >nul && echo 有A || echo 没有A
echo abcd|findstr "A" >nul && echo 有A || echo 没有A

echo -------------------------------------------------------------
echo abcd|findstr "^a" >nul && echo a开头 || echo 不是a开头
echo abcde|findstr "d$" >nul && echo d结尾 || echo 不d结尾
echo .abcd|findstr "^\." >nul && echo 点.开头 || echo 不点.开头

echo -----------------------------------------------------------------
::%a%|和 %a% | 会导致输出不一样
:: %a%不要加引号，会导致输出不一样

echo "%a%" | findstr /be "[0-9]*"
echo %errorlevel%


::/b，全英文begin，意为“开始”；
::/e，全英文end，意为“末端”；
::\<xyz 字位置: 字的开始
::xyz\> 字位置: 字的结束