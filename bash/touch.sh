#!/bin/sh
#

ttodir=$(date -d '+1 day' +%Y-%m-%d)
[ ! -d $ttodir ] && mkdir -p "$ttodir"

tf=$(date -d '+1 day' +%Y%m%d%H%M)
touch -t $tf "$ttodir"
echo $ttodir
echo $tf

