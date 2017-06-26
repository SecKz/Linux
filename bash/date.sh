#!/bin/sh
#
t1=$(date +%s)

sleep 2

usleep 25000

t2=$(date +%s)

echo $(( $t2-$t1 ))