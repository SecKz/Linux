#!/bin/sh
#

if [ $# = 1 ]; then
mem1=$(ps aux | grep "$1" |awk '{sum+=$6};END{print sum/1024}')
echo "$mem1"
exit
fi

ngx_mem=$(ps aux | grep nginx |awk '{sum+=$6};END{print sum/1024}')
apache_mem=$(ps aux | grep apache |awk '{sum+=$6};END{print sum/1024}')
php_mem=$(ps aux | grep php |awk '{sum+=$6};END{print sum/1024}')
mysql_mem=$(ps aux | grep mysql |awk '{sum+=$6};END{print sum/1024}')

echo "nginx: $ngx_mem"
echo "apache: $apache_mem"
echo "php: $php_mem"
echo "mysql: $mysql_mem"

echo --------------------------------------------------


mem=`free -m | awk 'NR==2{print $2}'`
ps -aux 2>&1 | sort -k 4 -r | awk '$4 ~ /^[0-9]/ && $4>0 {print $4,$11}' | awk '{print $1/100*mem"   "$2}' mem=$mem | sort -k 2 | awk '
{
   a[$2] += $1;
   b[$2]++;
   total += $1;
   total++;
}
END{
  for(i in a){
    t=i;
    gsub(/:|.*\//, "", t);
    printf "%10s   %s\n" ,a[i]"MB", t"["b[i]"]";
  }
print "Memory Total: "mem"MB, used: "total"MB, free: "mem-total"MB."
}' mem=$mem | sort -n -r


