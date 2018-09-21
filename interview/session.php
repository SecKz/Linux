<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>PHP如何修改session的生存时间</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<style type="text/css">
*{list-style:none;font-size:14px;font-family:tahoma;}
</style>
</head>
<body>
<pre>
PHP如何修改session的生存时间
一：在php.ini 中设置 session.gc_maxlifetime = 1440 //默认时间
二：代码实现
$lifeTime = 24 * 3600;  // 保存一天
session_set_cookie_params($lifeTime);
session_start();
</pre>
<hr />

<pre>

<?php

$lifeTime = 24;
session_set_cookie_params($lifeTime);
session_start();

if(!$_COOKIE['onetime']) {
	setcookie("onetime", 1, time()+3600);
	echo rand();
	$_SESSION['name'] = 'eric';
	$_SESSION['age'] = 30;
}

print_r($_COOKIE);
print_r($_SESSION);



?>

</pre>

</body></html>





















