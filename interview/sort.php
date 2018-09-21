<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>test</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<style type="text/css">
*{list-style:none;font-size:14px;font-family:tahoma;}
#content{width:1300px;height:500px;font-size:12px;padding:3px;}
</style>
</head>
<body>

<pre>
sort()
根据阵列中元素的值，以英文字母顺序排序，索引键会由 0 到 n-1 重新编号。主要是当阵列索引键的值无关疼痒时用来把阵列排序。
asort()
与 sort() 一样把阵列的元素按英文字母顺序来排列，不同的是所有索引键都获得保留，特别适合替联想阵列排序。
ksort()
根据阵列中索引键的值，以英文字母顺序排序，特别适合用于希望把索引键排序的联想阵列。
</pre>

<form method="post" action="" id="uploadform" enctype="multipart/form-data">

</form>

<hr />


<pre>


<?php

error_reporting(0);

$fruits = array("lemon", 50=>"orange", "banana", "apple");
sort($fruits);
print_r($fruits);

$fruits = array("d" => "lemon", "a" => "orange", "b" => "banana", "c" => "apple");
asort($fruits);
print_r($fruits);

ksort($fruits);
print_r($fruits);

?>


</pre>

</body>
</html>

