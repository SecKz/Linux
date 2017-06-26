#!/bin/sh
# 字符串比较

aa="August 15, 2012"  
bb="August 15, 20122"  
cc="123"  
dd="123"  

if [ "$aa" = "$bb" -o "$cc" = "$dd" ]; then  
    echo "yes"  
else  
    echo "no"  
fi  
 
if [ "$aa" != "$bb" -a "$cc" = "$dd" ]; then  
    echo "yes"  
else  
    echo "no"  
fi  

old_php_version=`php -r 'echo PHP_VERSION;'`
echo $old_php_version
if test -d $1; then
echo "it is a directory."
else
echo "it is not a directory."
fi