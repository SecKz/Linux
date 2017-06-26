#!/bin/sh
#
echo -n $1 | md5sum | awk '{print $1}'
echo -n $1 | sha1sum | awk '{print $1}'