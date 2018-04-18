#!/bin/sh

echo "check system info in lunux/ubuntu"
echo

echo "============= CPUs ==========================="

# CPU总核数 = 物理CPU个数 * 每颗物理CPU的核数
# 总逻辑CPU数 = 物理CPU个数 * 每颗物理CPU的核数 * 超线程数

echo "逻辑CPU的个数"
cat /proc/cpuinfo| grep "processor"| wc -l

echo "物理CPU个数"
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l

echo "每个物理CPU中core的个数(即核数)"
cat /proc/cpuinfo| grep "cpu cores"| uniq

echo " "

echo "============= CPUs Width   ==================="
LM=`cat /proc/cpuinfo | grep ' lm ' | wc -l`
if [ $LM -gt 0 ] ; then
	echo "64 Bits"
else
	echo "32 Bits"
fi

echo "============= Memory =========================="
KiB=`grep 'MemTotal' /proc/meminfo | tr -s ' ' | cut -d' ' -f2`
MiB=`expr $KiB / 1024`
#note various mem not accounted for, so round to appropriate size
#on my 384MiB system over 8MiB was unaccounted for
#on my 1024MiB system over 20MiB was unaccounted for so round to next highest power of 2
round=32
echo "`expr \( \( $MiB / $round \) + 1 \) \* $round` MiB"
echo " "

echo "============= Memory Used ====================="
KiB=`free | sed -n 3p | awk '{print $3}'`
MiB=`expr $KiB / 1024`
round=32
echo "`expr \( \( $MiB / $round \) + 1 \) \* $round` MiB"
echo " "

echo "============= Mem Max Capacity ================"
dmidecode -t Memory | grep 'Maximum Capacity' | sed -n 1p | awk '{print $3,$4}'
echo " "

#echo "============= Hard Disk ======================="
#fdisk -l | grep 'Dis' | cut -d',' -f1,3
#echo " "

echo "============= Hard Disk ======================="
df -h
echo " "

echo "============= Partitions Space ================"
df -h | grep '/dev/'
echo " "

echo "============= Hostname ======================="
hostname
echo " "

echo "============= Operating System ================"
cat /etc/issue.net
echo " "

echo "============= Linux Kernel ===================="
uname -mrs
echo " "

echo "============= UpTime =========================="
uptime | awk '{ print $3,$4,$5}' | sed -e "s/,//g"
echo " "

echo "============= IP Route ========================"
ip route | grep 'via'
echo " "

echo "============= IP Address ======================"
ifconfig | grep 'inet ad' | awk '{print $2}' | cut -d':' -f2 | sed /127.0.0.1/d
echo " "

echo "============= MAC Address ======================"
ifconfig | grep 'HWaddr' | sed -e "s/Link encap:Ethernet  HWaddr//g"
echo " "

echo "============= Serial Number =================="
dmidecode -s system-serial-number
echo " "
echo "============= carte graphic =================="
 lspci|grep VGA
echo " "

echo "============= Product Number ================="
dmidecode -t system | grep 'SKU Number' | sed -n 1p | cut -c14-
echo " "

echo "============= Manufacturer ==================="
dmidecode -s system-manufacturer
echo " "

echo "============= Product Name ==================="
dmidecode -s system-product-name
echo " "