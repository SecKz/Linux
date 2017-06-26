#/bin/bash
#########################################
#Function:    auto fdisk
#Usage:       bash auto_fdisk.sh
#Author:      Customer service department
#Company:     Alibaba Cloud Computing
#Version:     3.0
#########################################

count=0
tmp1=/tmp/.tmp1
tmp2=/tmp/.tmp2
>$tmp1
>$tmp2
fstab_file=/etc/fstab

#check lock file ,one time only let the script run one time 
LOCKfile=/tmp/.$(basename $0)

function red() {
    echo -e "\033[1;40;31m$*\033[0m"
}

function green() {
	echo -e "\033[40;32m$*\033[40;37m"
}

if [ -f "$LOCKfile" ];then
  red "The script is already exist,please next time to run this script."
 # exit
else
  green "Step 1.No lock file,begin to create lock file and continue."
  touch $LOCKfile
fi

#check user
if [ $(id -u) != "0" ]; then
  red "Error: You must be root to run this script, please use root to install this script."
  rm -rf $LOCKfile
  exit 1
fi

#check disk partition
check_disk(){
  >$LOCKfile

  device_list=$(fdisk -l|grep "Disk"|grep "/dev"|awk '{print $2}'|awk -F: '{print $1}')

  echo $device_list;

  for i in `echo $device_list`;  do
    device_count=$(fdisk -l $i|grep "$i"|awk '{print $2}'|awk -F: '{print $1}'|wc -l) 
	islvm=$(ls -l $i | grep '^l')								#不是LVM分区
	
    if [ $device_count -lt 2 -a -z "$islvm" ];    then
      now_mount=$(df -h)
      if echo $now_mount|grep -w "$i" >/dev/null 2>&1;  then
        red "The $i disk is mounted."
      else
		echo $i >>$LOCKfile
        green "$i未使用"
      fi
    fi
  done


  disk_list=$(cat $LOCKfile)
  if [ "X$disk_list" == "X" ];  then
    echo -e "\033[1;40;31mNo free disk need to be fdisk.Exit script.\033[0m"
    rm -rf $LOCKfile
    exit 0
  else
    green "This system have free disk :"
    for i in `echo $disk_list`;    do
      echo "$i"
      count=$((count+1))
    done
  fi
}

#fdisk ,formating and create the file system
fdisk_fun(){
fdisk -S 56 $1 << EOF
n
p
1


wq
EOF

sleep 5
mkfs.ext4 ${1}1
}

#make directory
make_dir(){
  green "Step 4.Begin to make directory"
  now_dir_count=$(ls /|grep "alidata*"|awk -F "data" '{print $2}'|sort -n|tail -1)
  if [ "X$now_dir_count" ==  "X" ]
  then
    for j in `seq $count`;    do
      echo "/alidata$j" >>$tmp1
      mkdir /alidata$j
    done
  else
    for j in `seq $count`;    do
      k=$((now_dir_count+j))
      echo "/alidata$k" >>$tmp1
      mkdir /alidata$k
    done
  fi
 }

#config /etc/fstab and mount device
main(){
  for i in `echo $disk_list`;  do
    green "Step 3.Begin to fdisk free disk."
    fdisk_fun $i
    echo "${i}1" >>$tmp2
  done
  make_dir
  >$LOCKfile
  paste $tmp2 $tmp1 >$LOCKfile
  green "Step 5.Begin to write configuration to /etc/fstab and mount device."
  while read a b;  do
    if grep -v ^# $fstab_file|grep ${a} >/dev/null
    then
      sed -i "s=${a}*=#&=" $fstab_file
    fi
    echo "${a}             $b                 ext4    defaults        0 2" >>$fstab_file
  done <$LOCKfile
  mount -a
}

#=========start script===========
green "Step 2.Begin to check free disk."
check_disk
#main
#df -h
#rm -rf $LOCKfile $tmp1 $tmp2
