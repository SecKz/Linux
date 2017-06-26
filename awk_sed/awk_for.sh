#!/bin/sh
#
awk 'BEGIN{
array[1]="it"
array[2]="homer"
array[3]="sunboy"
array[4]=2050


array["first"]="yang"
array["second"]="gang"
array["third"]="sunboy"


print array[1], array[4]
print array[3], array["third"]}'
