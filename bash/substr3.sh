#!/bin/sh
# 判断是否含有子串，也可以用grep


s='hello, eric, how are you. /var/lib/php/session/'

if [[ $s = *session* ]]; then
 echo "含有session"
fi

if [[ $s = *d/session/* ]]; then
 echo "含有d/session/"
fi

if [[ $s = */session/* ]]; then
 echo "含有/session/"
fi


[[ 'how are you' =~ 'how' ]] && date
