#!/bin/sh
#
date
(date)
$(date)			#报错 a=$(date)不会报错
echo $(date) 