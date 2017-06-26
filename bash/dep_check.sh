#!/bin/sh
#检查包的依赖性的示例脚本
#http://www.cnblogs.com/nufangrensheng/p/3479182.html
#This is used to query the package dependencies.

function query()
{
        #定义查询包的行、包名称和最大行数三个变量
        LINE=0
        PACKET=null
        MAX=`ls $2/*.rpm | wc -l`
        #使用while循环处理包查询过程
        while true
        do
    #定义循环过程
    #每次开始时将查询包的行增加1
                LINE=`expr $LINE + 1`
    #判断当前查询到包是否大于最大包数量，如果是则返回提示信息，并返回脚本
                if [ $MAX -lt $LINE ]
                 then
                        echo "Not find any package."
                        #清除变量，并设置返回状态后返回
            unset LINE PACKET MAX
                        return 1
                fi
    #获取第LINE行的包名称
                PACKET=`ls $2/*.rpm | sed -n ${LINE}p`
                #使用三个命令判断包内是否含有要查找的文件
                   #先使用rpm -pql列出变量PACKET指向的软件包内所有的文件列表
    #同时重定向错误到系统回收池/dev/null
    #再使用命令grep -v去掉可能的错误和警告，并将错误重定向到系统回收池
    #最后使用grep $1查询第1个参数指定的文件
    #并将查找到的结果和错误都重定向到系统回收池
                rpm -pql $PACKET 2>/dev/null | grep -v "warning:" 2>/dev/null | grep $1 &>/dev/null
                #判断上一条命令是否成功执行，如果是则返回查找到的包名称
    if [ $? = 0 ] 
                then
            #使用echo命令返回查找到的包名称
                        echo $PACKET
            #清除使用的变量，设置返回状态
                        unset LINE PACKET MAX
                        return 0
                fi
        #循环结束标志  
        done
}


#脚本主体部分
#检查脚本执行时是否带有一个参数
#如果没有则返回错误并退出
if [ $# != 1 ]
 then
        echo "Must have a parameter."
        echo "Usage:"$0" parameter"
        exit 1
fi

#设置RPM软件包所在目录变量
PACKET_DIR=/media/cdrom/Server
#设置要查询到文件名称
DEPEND_FILE=$1
#用于获取函数返回值的变量
MESSAGE=null

#输出提示信息并开始查询
echo "Querying,please wait..."
#调用函数并判断函数的执行状态
#函数的第1个参数是要查询的文件名，第2个参数是RPM软件包目录
if MESSAGE=`query $DEPEND_FILE $PACKET_DIR`
 then
        #输出成功查询的提示信息，并将结果输出给用户
        echo "Query is completed."
        echo "File where the package is::"
        echo "  "$MESSAGE
        #清除使用过的变量和函数
        unset PACKET_DIR MESSAGE DEPEND_FILE query
        #设置脚本的退出状态为无错误退出
        exit 0
 else
       #输出没有找到文件的相关提示信息，并设置返回状态为有错误退出
        echo "Query is completed."
        echo $MESSAGE
       #清除使用过的函数和变量
        unset PACKET_DIR MESSAGE DEPEND_FILE query
        exit 1
fi