#!/bin/sh
#
if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
     echo 64位
else
    echo 32位
fi