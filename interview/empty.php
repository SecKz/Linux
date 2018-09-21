<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>empty</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<style type="text/css">
*{list-style:none;font-size:14px;font-family:tahoma;}
#content{width:1300px;height:500px;font-size:12px;padding:3px;}
</style>
</head>
<body>

<pre>
empty()：""、0、"0"、NULL、FALSE、array(),未定义，均返回true；
</pre>

<form method="post" action="" id="uploadform" enctype="multipart/form-data">

</form>

<hr />


<pre>


<?php

error_reporting(0);


echo 10+"10",'<br />';
echo 10+"10aa",'<br />';
echo 10+"aa",'<br />';
echo 10-"10aa",'<br />';

var_dump("0"=="as");	//  false
var_dump("0"=="0as");	//  false
var_dump("1"=="as");	//  false
var_dump(1=="as");		//  false
var_dump("1"=="1as");	//  false

echo '<br />';


var_dump("0" < "as");	//true
var_dump("5" < "as");	//true
var_dump("56" < "5as");	//true

var_dump(21=="21ggg");	//true
var_dump(1 > "as");	  //true
var_dump(1 < "2as");	  //true
var_dump(1 < "1.1as");	  //true

echo '<br />';

$a1 = null;
$a2 = false;
$a3 = 0;
$a4 = "";
$a5 = '0';
$a6 = array();

$a7 = 'null';
$a8 = array(array());

var_dump('0'==false);//true
var_dump(empty($a1));//true
var_dump(empty($a2));//true
var_dump(empty($a3));//true
var_dump(empty($a4));//true
var_dump(empty($a5));//true
var_dump(empty($a6));		//true

var_dump(empty($a7));		//false
var_dump(empty($a8));		//false

?>


</pre>

</body>
</html>

