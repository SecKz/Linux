<!DOCTYPE html>
<html>
<head>
<title>引用操作符&</title>
<meta charset="gb2312">
<style type="text/css">
*{list-style:none;font-size:14px;font-family:tahoma;}
</style>

</head>

<body>
<pre>

引用操作符& 使用引用操作符可以使两个$变量指向同一个内存地址。从而节省下宝贵的资源。

15、请说明php中传值与传引用的区别。什么时候传值什么时候传引用?(2分)
答:按值传递：函数范围内对值的任何改变在函数外部都会被忽略
按引用传递：函数范围内对值的任何改变在函数外部也能反映出这些修改
优缺点：按值传递时，php必须复制值。特别是对于大型的字符串和对象来说，这将会是一个代价很大的操作。
按引用传递则不需要复制值，对于性能提高很有好处。
</pre>
<hr>

<?php

$a = 5;
$b = &$a;
echo $a , ',', $b,"<br>";
$a = 100 ;
unset($a);
echo $a,"---<br>";
echo $b,"+++<br>";

function foo(&$a,&$b) {
//global $b;
	$a = $a + 10;
	$b = 20;
}

echo '<hr />';

$c = 100;
$d = 99;
foo($c,$d);

echo $c,'<br />';
echo $d,'<br />';

?>

</body></html>





















