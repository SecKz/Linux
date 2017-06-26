#!/bin/sh
# 
check_disk()
{
  >$LOCKfile
  device_list=$(fdisk -l|grep "Disk"|grep "/dev"|awk '{print $2}'|awk -F: '{print $1}')
  for i in `echo $device_list`
  do
    device_count=$(fdisk -l $i|grep "$i"|awk '{print $2}'|awk -F: '{print $1}'|wc -l)
    echo 
    if [ $device_count -lt 2 ]
    then
      now_mount=$(df -h)
      if echo $now_mount|grep -w "$i" >/dev/null 2>&1
      then
        echo -e "\033[40;32mThe $i disk is mounted.\033[40;37m"
      else
        echo $i >>$LOCKfile
        echo "You have a free disk,Now will fdisk it and mount it."
      fi
    fi
  done
  disk_list=$(cat $LOCKfile)
  if [ "X$disk_list" == "X" ]
  then
    echo -e "\033[1;40;31mNo free disk need to be fdisk.Exit script.\033[0m"
    rm -rf $LOCKfile
    exit 0
  else
    echo -e "\033[40;32mThis system have free disk :\033[40;37m"
    for i in `echo $disk_list`
    do
      echo "$i"
      count=$((count+1))
    done
  fi
}

check_disk
