#!/bin/sh
echo "check system info in lunux/ubuntu"
##
# Description: Executable et fichier de config
#
# Author: Ismail Elyaakouby <elyakouby@gmail.com> / moujan
# Contributor: none
#
#
# Copyright(c) 2013-2014 Ismail Elyaakouby
#
# Web site : http://www.tutorials-space.com
##
#!/bin/bash
echo -e "============= Hostname =======================\n"
hostname
echo " "

echo -e "============= Serial Number ==================\n"
dmidecode -s system-serial-number
echo " "
echo -e "============= carte graphic ==================\n"
 lspci|grep VGA
echo " "


echo -e "============= Product Number =================\n"
dmidecode -t system | grep 'SKU Number' | sed -n 1p | cut -c14-
echo " "

echo -e "============= Manufacturer ===================\n"
dmidecode -s system-manufacturer
echo " "

echo -e "============= Product Name ===================\n"
dmidecode -s system-product-name
echo " "

echo -e "============= CPUs ===========================\n"
grep 'model name' /proc/cpuinfo | tr -s ' ' | cut -c14-
echo " "

echo -e "============= CPUs Width   ===================\n"
LM=`cat /proc/cpuinfo | grep ' lm ' | wc -l`
if [[ $LM -gt 0 ]] ; then
echo -e "64 Bits\n"
else echo -e "32 Bits\n"
fi
#(long mode) 64 bits
#(protected mode) 32 bits
#(real mode) 16 bits

#echo -e "============= CPUs Temp =============\n"
#COUNTER=`sensors|grep temp | tail -n 1 |  cut -d':' -f1,3 | sed -e "s/temp//g"`
#COUNTER=`sensors|grep temp|tail -n 1|awk '{print $2}'|cut -c2-5`

echo -e "============= Memory ==========================\n"
KiB=`grep 'MemTotal' /proc/meminfo | tr -s ' ' | cut -d' ' -f2`
MiB=`expr $KiB / 1024`
#note various mem not accounted for, so round to appropriate size
#on my 384MiB system over 8MiB was unaccounted for
#on my 1024MiB system over 20MiB was unaccounted for so round to next highest power of 2
round=32
echo "`expr \( \( $MiB / $round \) + 1 \) \* $round` MiB"
echo " "

echo -e "============= Memory Used =====================\n"
KiB=`free | sed -n 3p | awk '{print $3}'`
MiB=`expr $KiB / 1024`
round=32
echo "`expr \( \( $MiB / $round \) + 1 \) \* $round` MiB"
echo " "

echo -e "============= Mem Max Capacity ================\n"
dmidecode -t Memory | grep 'Maximum Capacity' | sed -n 1p | awk '{print $3,$4}'
echo " "

echo -e "============= Hard Disk =======================\n"
fdisk -l | grep 'Dis' | cut -d',' -f1,3
echo " "

echo -e "============= Hard Disk =======================\n"
df -h
echo " "

echo -e "============= Partitions Space ================\n"
df -h | grep '/dev/'
echo " "

echo -e "============= Operating System ================\n"
cat /etc/issue.net
echo " "

echo -e "============= Linux Kernel ====================\n"
uname -mrs
echo " "

echo -e "============= UpTime ==========================\n"
uptime | awk '{ print $3,$4,$5}' | sed -e "s/,//g"
echo " "

echo -e "============= IP Route ========================\n"
ip route | grep 'via'
echo " "

echo -e "============= IP Address ======================\n"
ifconfig | grep 'inet ad' | awk '{print $2}' | cut -d':' -f2 | sed /127.0.0.1/d
echo " "

echo -e "============= MAC Address ======================\n"
ifconfig | grep 'HWaddr' | sed -e "s/Link encap:Ethernet  HWaddr//g"
echo " "
