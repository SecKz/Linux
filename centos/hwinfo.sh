#!/bin/sh

echo "check system info in lunux/ubuntu"
echo

echo "============= CPUs ==========================="

# CPU总核数 = 物理CPU个数 * 每颗物理CPU的核数
# 总逻辑CPU数 = 物理CPU个数 * 每颗物理CPU的核数 * 超线程数

echo "CPU型号"
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c

echo "逻辑CPU的个数"
cat /proc/cpuinfo| grep "processor"| wc -l

echo "物理CPU个数"
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l

echo "每个物理CPU中core的个数(即核数)"
cat /proc/cpuinfo| grep "cpu cores"| uniq

echo "每个核心线程数"
lscpu | grep 'Thread(s) per core'

echo
echo 'CPU总核数 = 物理CPU个数 * 每颗物理CPU的核数'
echo '总逻辑CPU数 = 物理CPU个数 * 每颗物理CPU的核数 * 超线程数'

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

# lscpu

#Architecture:          i686                            #架构686
#CPU(s):                2                                   #逻辑cpu颗数是2
#Thread(s) per core:    1                           #每个核心线程数是1
#Core(s) per socket:    2                           #每个cpu插槽核数/每颗物理cpu核数是2
#CPU socket(s):         1                            #cpu插槽数是1
#Vendor ID:             GenuineIntel           #cpu厂商ID是GenuineIntel
#CPU family:            6                              #cpu系列是6
#Model:                 23                                #型号23
#Stepping:              10                              #步进是10
#CPU MHz:               800.000                 #cpu主频是800MHz
#Virtualization:        VT-x                         #cpu支持的虚拟化技术VT-x(对此在下一博文中解释下http://hi.baidu.com/sdusoul/blog/item/5d8e0488def3a998a5c272c0.html)
#L1d cache:             32K                         #一级缓存32K（google了下，这具体表示表示cpu的L1数据缓存为32k）
#L1i cache:             32K                          #一级缓存32K（具体为L1指令缓存为32K）
#L2 cache:              3072K                      #二级缓存3072K


