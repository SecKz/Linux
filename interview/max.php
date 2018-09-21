<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>max</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<style type="text/css">
*{list-style:none;font-size:14px;font-family:tahoma;}
#content{width:1300px;height:500px;font-size:12px;padding:3px;}
</style>
</head>
<body>

<pre>
3、用PHP打印出前一天的时间，打印格式是2007年5月10日22:21:21
echo date("Y-m-d H:i:s",strtotime("-1 day"));
</pre>


<hr />


<pre>


<?php

var_dump(7=="7");


echo max(1, 3, 5, 6, "7"),'<br />';  // 7
echo max(array(2, 4, 5)),'<br />'; // 5
echo max(0, 'hello'),'<br />';     // 0
echo max('hello', 0),'<br />';     // hello
echo max(-1, 'hello'),'<br />';    // hello

?>


</pre>

</body>
</html>

