::截取字符串
@echo off
color 0A
set var=0123456789
echo 原字符串（第二行为各字符的序号）：
echo %var%
echo 截取前5个字符：
echo %var:~0,5%
echo 截取最后5个字符：
echo %var:~-5%
echo 截取第一个到倒数第6个字符：
echo %var:~0,-5%
echo 从第4个字符开始，截取5个字符：
echo %var:~3,5%
echo 从倒数第14个字符开始，截取5个字符：
echo %var:~-7,5%


echo 字符串合并 其实，合并字符串就是将两个字符串放在一起就可以了

set aa=伟大的中国！
set bb=我为你自豪！
echo %aa%%bb%
echo aa=%aa%
echo bb=%bb%
set "aa=%aa%%bb%"
echo aa=%aa%
