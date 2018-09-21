
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>_SERVER</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<style type="text/css">
*{list-style:none;font-size:14px;font-family:tahoma;}
#content{width:1300px;height:500px;font-size:12px;padding:3px;}
</style>
</head>
<body>

<pre>
PHP_SELF,SCRIPT_NAME
__FILE__,SCRIPT_FILENAME
</pre>



<hr />


<pre>


<?php


echo $_SERVER['REMOTE_ADDR'],'<br />';
echo $_SERVER['SERVER_ADDR'],'<br />';
echo getenv("server_addr"),'<br />';
echo getenv("remote_addr"),'<br />';

echo '<hr />';

echo $_SERVER['PHP_SELF'],'<br />';
echo $_SERVER['SCRIPT_NAME'],'<br />';
echo $_SERVER["QUERY_STRING"],'<br />'; // 返回?后面的 aa=dd&dd=dd
echo __FILE__,'<br />';
echo $_SERVER['SCRIPT_FILENAME'],'<br />';

echo $_SERVER["DOCUMENT_ROOT"],'<br />';

?>


</pre>

</body>
</html>

