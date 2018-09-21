PHP支持多继承吗？
回答：不可以。PHP类只能继承一个父类，并用关键字“extends”标识。


第4题:简述一下echo、print、print_r 区别
* print_r()主要用来输出数组的结构;echo 和 print 主要用来输出字符串,只不过echo 可同时输出多个字符串,print 只能输出一个字符串;
* echo 和 print 区别:
(1)使用命令方式来输出字符串
(2)使用函数方式来输出字符串,echo无返回值,print有返回值,成功返回 1,失败返回 0


php断点调试的几种方法讨论
die()和exit()函数都有终止线程的作用，是php断点调试需要使用的最主要的函数
php断点调试用Zend Debugger，简单方便


4. 如何对一个变量进行值传递?
可以像C++那样， 在变量的前面加上&, 例如：$a = &$b

引用操作符& 使用引用操作符可以使两个$变量指向同一个内存地址。从而节省下宝贵的资源。
$a=100; $b = &$a; echo $a."\n",$b; $a = 120;echo '<br />'; unset($a); echo $a."\n",$b;

5. 在PHP里面可以对string "10″ 和整型 11进行比较吗?
可以，PHP内部实现会把所有东西转换成整型，所以数字10和11可以进行比较

PHP里面如何定义一个常量(constant)?
通过define()指令，例如：define("MYCONSTANT", 100)

1. 如何用php的环境变量得到一个网页地址的内容?ip地址又要怎样得到?

程序代码
echo $_SERVER ["PHP_SELF"];
echo $_SERVER ["SERVER_ADDR"];

正在浏览当前页面用户的 IP 地址:127.0.0.1
echo $_SERVER["REMOTE_ADDR"].

查询（query）的字符串（URL 中第一个问号 ? 之后的内容）:id=1&bi=2
echo $_SERVER["QUERY_STRING"].

当前运行脚本所在的文档根目录:d:inetpubwwwroot
echo $_SERVER["DOCUMENT_ROOT"].


2. 求两个日期的差数，例如2007-2-5 ~ 2007-3-6 的日期差数

程序代码
$begin=strtotime("2007-2-5″);
$end=strtotime("2007-3-6″);
echo ($end-$begin)/(24*3600);


safe_mode安全模式
ini_set("safe_mode",true);  PHP安全模式在5.4的时候已经不再支持
由于启用了安全模式后，由于会对比文件的拥有者和文件的执行者是否是一个人，所以会减慢执行效率。
如果UID相同，则执行脚本；否则，脚本失败。

下面是启用safe_mode指令时受影响的函数、变量及配置指令的完整列表：
fopen()、file()和require() mysql_* exec() system()  mkdir()   touch()chdir()chgrp()     chmod()    chown() copy() header()

表单中 get与post提交方法的区别?
get是发送请求HTTP协议通过url参数传递进行接收
而post是实体数据,可以通过表单提交大量信息.

get是从服务器上获取数据，post是向服务器传送数据
GET请求的数据会附在URL之后（就是把数据放置在HTTP协议头中），以?分割URL和传输数据，参数之间以&相连，如：login.action?
POST把提交的数据则放置在是HTTP包的包体中。
GET方式提交的数据最多只能是1024字节，理论上POST没有限制，可传较大量的数据

include和require有什么区别?
区别在于他们如何处理失败， 如果require的文件没有找到， 会造成fatal error，脚本停止执行，如果include的文件没有找到， 会显示警告，但是脚本会继续执行。

php class中static,public,private,protected的区别?
static 静态，类名可以访问
public 表示全局，类内部外部子类都可以访问；
private表示私有的，只有本类内部可以使用；
protected表示受保护的，只有本类或子类或父类中可以访问；

 写出一些php魔幻（术）方法;
__construct() 实例化类时自动调用。
__destruct() 类对象使用结束时自动调用。
__set() 在给未定义的属性赋值的时候调用。
__get() 调用未定义的属性时候调用。
__isset() 使用isset()或empty()函数时候会调用。
__unset() 使用unset()时候会调用。
__sleep() 使用serialize序列化时候调用。
__wakeup() 使用unserialize反序列化的时候调用。
__call() 调用一个不存在的方法的时候调用。
__callStatic()调用一个不存在的静态方法是调用。
__toString() 把对象转换成字符串的时候会调用。比如 echo。
__invoke() 当尝试把对象当方法调用时调用。
__set_state() 当使用var_export()函数时候调用。接受一个数组参数。
__clone() 当使用clone复制一个对象时候调用。

