#!/bin/sh
# 用ping命令发送4个ICMP数据包测试双向连通性，并用awk从中计算最大延时、最小延时和平均延时的示例：
# http://www.cnblogs.com/nufangrensheng/p/3463892.html
BEGIN{
        #使用重新定义变量FS的方法设置域分隔符为冒号、等号及空格
        FS="[:= ]";
        AVG=0;
        MAX=0;
        MIN=0;
}
{
        for(I=1;I<9;I++)
        {
               #如果当前为第二条记录，则为变量MAX、MIN、IP_ADDR赋值
                if(NR==2)
                {
                        MAX=$11;
                        MIN=$11;
                        IP_ADDR=$4;
                }
                if(NR>1 && NR<6)
                {
           #计算延时总和
                        AVG+=$11;
                        if($11>MAX)
                                MAX=$11;
                        if($11<MIN)
                                MIN=$11;
                }
    #如果记录数大于6，则跳出循环并执行END中的表达式
                if(NR>=6)
                        exit;
    #否则，读取系一条记录，重新开始循环
                next;
        }
}
END{
        AVG=AVG/4;
        print "IP address:",IP_ADDR;
        print "Avg:",AVG,"ms";
        print "Max:",MAX,"ms";
        print "Min:",MIN,"ms";
}