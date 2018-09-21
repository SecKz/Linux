
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>date</title>
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
echo strtotime('-1'),'<br />';
echo strtotime('-1 day'),'<br />';
echo date('Y-m-d H:i:s',time()),'<br />';
echo date('Y-m-d H:i:s', strtotime('-1')),'<br />';
echo date('Y-m-d H:i:s', strtotime('-1 day')),'<br />';
echo date('Y-m-d H:i:s', strtotime('-1 week')),'<br />';
echo date('Y-m-d H:i:s', strtotime('-1 month')),'<br />';
echo date('Y-m-d H:i:s', strtotime('1 day')),'<br />';
echo date('Y-m-d H:i:s',strtotime('1 day')),'<br />';

echo date('Y-m-d H:i:s', strtotime("-1")),'<br />';

?>


</pre>

</body>
</html>

