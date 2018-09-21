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


</pre>
<hr />

<pre>

<?php


echo 33,66, '<br />';

$str="abcdefg";
echo $str[3]."<br/>";

$a = "hello";
$b = &$a;
unset($b);
$b = "world";
//答案为:hello
echo $a, '<br />';

function strrevd($str) {
	$res = '';
	for($i=0; $i < strlen($str); $i++ ) {
		$res .= $str[$i].$res;

	}
	return $res;

}


//session_set_cookie_params

function isEmail($s)
{
	return preg_match('/^[\w\.\-]+@[\w\-]+\.[a-zA-Z\.]{2,10}$/', $s);
}

function isEmail($str) {
	return preg_match('^/[\w\.\-]+@[\w\.]\.[a-zA-Z\.]{2,10}$/', $str);

}

function is3email($str) {
	return preg_match('/^[\w\-\.]+@[\w\-]+\.[a-zA-Z\.]{2,10}/', $str);

}

echo date('Y-m-d H:i:s', strtotime('1 day')),'<br />';
echo (print "ddd")."<br/>";

$input = array("a" => "green", "red", "b" => "green", "blue", "red");
$result = array_unique($input);
print_r($result);
print_r($input);

$input = array(4, "4", "3", 4, 3, "3");
$result = array_unique($input);
print_r($result);

echo <<<EOT
<h1>DDDD</h1>
EOT;


echo '----------------------------------------<br />';
echo mb_strlen('aa对的','utf8'),'<br />';
echo mb_substr('aa对方对对方',0,5,'utf-8'),'<br />';

//addslashes()与 htmlspecialchars() 区别
//print_r(getimagesize('../IMG_0379.JPG'));

function get_ext($file) {
	return strrchr($file,'.');

}

$file = 'https://www.ss.cp/aafs/adfsdaf.php';
echo get_ext($file),'<br />';
echo array_pop(explode('.', $file));
print_r(pathinfo($file));

//getenv('remote_addr');
//array_keys
//array_values
//array_unique
//array_reverse
//in_array()
//array_flip
//array_key_exists
//array_count_values
//array_slice()

function scandird($dir) {
	if(!is_dir($dir)) return;
	$dh = opendir($dir);
	while(($file = readdir($dh))!==false) {
		if($file=='.' || $file=='..') continue;

	}
	closedir($dh);

}

//opendir();
//$file = readdir($dh);




?>

</pre>

</body></html>





















