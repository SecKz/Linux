
# echo -e "\033[1;字背景颜色;字体颜色m字符串\033[0m"  1;设置高亮度
# 高亮		 echo -e "\033[1;40;31m文字my word\033[0m"
# 不高亮	 echo -e "\033[40;31m文字my word\033[0m"

function red() {
    echo -e "\033[1;40;31m$*\033[0m"
}

function green() {
	echo -e "\033[1;40;32m$*\033[0m"
}

function yellow() {
	echo -e "\033[1;40;33m$*\033[0m"
}

function blue() {
	echo -e "\033[1;40;34m$*\033[0m"
}

function purple() {
	echo -e "\033[1;40;35m$*\033[0m"
}

function check_disk(){
  device_list=$(fdisk -l|egrep "^Disk /dev/"|awk '{print $2}'|awk -F: '{print $1}')
 # purple "$device_list"
  echo '---------------------------------------';
  for i in `echo $device_list`;  do
    device_count=$(fdisk -l $i|grep "$i"|awk '{print $2}'|awk -F: '{print $1}'|wc -l)

	islvm=$(ls -l $i | grep '^l')								#是LVM分区
	if [ -n "$islvm" ]; then
		purple "$i是LVM分区"
		continue
	fi

    if [ $device_count -gt 1 ]; then
      now_mount=$(df -h)
      if echo $now_mount|grep "$i" >/dev/null 2>&1;  then
        blue "$i已挂载."
      else
        green "$i未使用"
      fi
    fi
  done
}

