#!/bin/bash
# BLOG:  https://blog.linuxeye.com
#  https://github.com/lj2007331/oneinstack

# swapoff -a
# swapoff /dev/mapper/centos-swap

echo '创建交换分区swap'

Mem=`free -m | awk '/Mem:/{print $2}'`
Swap=`free -m | awk '/Swap:/{print $2}'`

echo $Mem, $Swap

setSwap() {
  dd if=/dev/zero of=/swapfile count=$COUNT bs=1M
  mkswap /swapfile
  swapon /swapfile
  chmod 600 /swapfile
  [ -z "`grep swapfile /etc/fstab`" ] && echo '/swapfile    swap    swap    defaults    0 0' >> /etc/fstab
}

if [ "$Swap" == '0' ]; then
  if [ $Mem -le 2048 ]; then
    COUNT=512
  elif [ $Mem -gt 2048 ]; then
    COUNT=1024
  fi
	setSwap
fi