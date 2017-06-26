#!/bin/sh
# 在bash中，数字的比较最好使用 (( ))
# 使用 (( )) 时，不需要空格分隔各值和运算符，使用 [[ ]] 时需要用空格分隔各值和运算符。
#  [[ $a == z* ]]	如果$a以"z"开头(模式匹配)那么将为true
# [[ $a == "z*" ]]	如果$a等于z*(字符匹配),那么结果为true
# [[]]支持bash中的通配符扩展，如：[[ hest = h??t ]] 、[ hest = h*t ]]

read -p "输入字符串:" str

if [[ "$str" = z* ]]; then      # 模式匹配
echo ${str}以z开头
else
echo ${str}不以z开头
fi

if [[ "$str" = "z*" ]]; then		# 字符匹配
echo ${str}等于z*
else
echo ${str}不等于z*
fi


[[ zoom == z**m ]] && date
[[ zoom == z??m ]] && date

[ "$str" = z* ] && pwd
[ "$str" = "z*" ] && pwd

