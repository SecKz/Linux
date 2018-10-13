<pre>
<?php

error_reporting(E_ALL ^ E_NOTICE);
date_default_timezone_set("PRC");

header('Content-Type:text/html;charset=UTF-8');
session_start();

echo date('Y-m-d H:i:s',time()),'<br />';

echo $_SERVER['SERVER_ADDR'],'<br />';
echo $_SERVER['REMOTE_ADDR'],'<br />';
echo getip(),'<br />';

function getip()
{
	if ($_SERVER['REMOTE_ADDR']) $ip = $_SERVER['REMOTE_ADDR'];
	else if (getenv('HTTP_X_FORWARDED_FOR')) $ip = getenv('HTTP_X_FORWARDED_FOR');
	else if (getenv('HTTP_CLIENT_IP')) $ip = getenv('HTTP_CLIENT_IP');
	$long = sprintf("%u",ip2long($ip));
    $ip   = $long ? $ip : '0.0.0.0';
	return $ip;
}

echo PHP_OS,'<br />';
echo __FILE__,'<br />';

echo '<br />----------------------------------------<br />';

if(!$_SESSION['aa']) {
	$_SESSION['aa'] = mt_rand();
}

print_r($_SESSION);

echo session_save_path(),'<br />';
echo session_name(),'<br />';
echo session_id(),'<br />';

$arr = glob("/*");
print_r($arr);

?>
</pre>


<?php
phpinfo();
?>


