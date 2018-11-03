#!/bin/sh
# https://segmentfault.com/a/1190000009506375
# QPS (Query per second) （每秒查询量）
# TPS(Transaction per second) （每秒事务量，如果是InnoDB会显示，没有InnoDB就不会显示）

# 使用mysqladmin extended-status命令可以获得所有MySQL性能指标，即show global status的输出，不过，因为多数这些指标都是累计值，
# 如果想了解当前的状态，则需要进行一次差值计算，这就是mysqladmin extended-status的一个额外功能，非常实用。默认的，使用extended-status，看到也是累计值，
# 但是，加上参数-r(--relative)，就可以看到各个指标的差值，配合参数-i(--sleep)就可以指定刷新的频率

# Threads_con 当前连接的线程的个数
# Threads_run 运行状态的线程的个数

# mysqladmin -u root -p123456 -h localhost status  这条命令返回MYSQL当前状态的几个值
# mysqladmin -uroot -r -i 1 -p123456 extended-status |grep "Questions\|Queries\|Innodb_rows\|Com_select \|Com_insert \|Com_update \|Com_delete "

mysqladmin -uroot -hlocalhost -p123456 extended-status -i1|awk 'BEGIN{local_switch=0;print "QPS   Commit Rollback   TPS    Threads_con Threads_run \n------------------------------------------------------- "}
     $2 ~ /Queries$/            {q=$4-lq;lq=$4;}
     $2 ~ /Com_commit$/         {c=$4-lc;lc=$4;}
     $2 ~ /Com_rollback$/       {r=$4-lr;lr=$4;}
     $2 ~ /Threads_connected$/  {tc=$4;}
     $2 ~ /Threads_running$/    {tr=$4;
        if(local_switch==0)
                {local_switch=1; count=0}
        else {
                if(count>10)
                        {count=0;print "------------------------------------------------------- \nQPS   Commit Rollback   TPS    Threads_con Threads_run \n------------------------------------------------------- ";}
                else{
                        count+=1;
                        printf "%-6d %-8d %-7d %-8d %-10d %d \n", q,c,r,c+r,tc,tr;
                }
        }
}'''

