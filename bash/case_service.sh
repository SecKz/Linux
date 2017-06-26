#!/bin/sh
#
#/etc/init.d/ 目录下的各类脚本中，大量使用了case分支语句结构


case   $1   in
    start)
        echo  "Start MySQL service."
        ;;
    stop)
        echo  "Stop MySQL service."
        ;;
    *)
        echo  "Usage：$0  start|stop"
        ;;
esac

echo ----------------------------------------------------------

read  -p  "Press some key, then press Return:"  KEY
case  "$KEY"  in
	[a-zA-Z])
      echo "是个字母"
      ;;
	[\&!\`\'\"%^%$#-+=@])
     echo "是特殊字符"
      ;;
	[0-9])
      echo "It's a digit."
      ;;
  *)
      echo "It's function keys、Spacebar or other keys. "
esac