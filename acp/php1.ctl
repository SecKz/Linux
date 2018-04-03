#TITLE=PHP常用
#SORT=y

#T=$_SERVER['HTTP_REFERER']
$_SERVER['HTTP_REFERER']
#T=$_SERVER['REQUEST_METHOD']
$_SERVER['REQUEST_METHOD']
#T=authenticate访问验证
define('ADMIN_USERNAME','apc');
define('ADMIN_PASSWORD','123');

if ($_SERVER['PHP_AUTH_USER'] != ADMIN_USERNAME || $_SERVER['PHP_AUTH_PW'] != ADMIN_PASSWORD) {
	Header('WWW-Authenticate: Basic realm="User Login"');
	Header("HTTP/1.0 401 Unauthorized");
	echo '<h1>401 Unauthorized</h1>';
	exit;
}

#T=debug_backtrace方法被调用位置
print_r(debug_backtrace());
#T=debug_backtrace简化
function removeBacktraceArg($a){
	foreach($a as $k=>$v){
		if($k=='args' || $k=='object') unset($a[$k]);
	}
	return $a;
}

printr(array_map('removeBacktraceArg', debug_backtrace()));
#T=extract($row,EXTR_PREFIX_ALL,'r');
extract($row, EXTR_PREFIX_ALL, 'r');
#T=get_declared_classes全部类名
print_r(get_declared_classes());
#T=get_defined_constants所有自定义常量
$gdconstants = get_defined_constants(true);
print_r($gdconstants['user']);
#T=get_defined_functions所有自定义函数
$gdfunctions = get_defined_functions();
print_r($gdfunctions['user']);
#T=get_defined_vars()所有变量
print_r(get_defined_vars());
#T=get_included_files所有引入文件
print_r(get_included_files());
#T=mysql特定语句追踪查询
if(strpos($sql, 'seller_name')!==false) {
    printr(array_map('removeBacktraceArg', debug_backtrace()));die();
}
#T=php中html注释
echo "\n\r<!--  ";
^!

echo " -->";
#T=session_write_close();
session_write_close();
#T=substr-strstr-strpos
$host = "www.120.com";

echo strstr($host, "."),'<br />';
echo substr(strstr($host, "."), 1),'<br />';
echo substr($host, strpos($host, '.')),'<br />';

#T=xdebug_get_function_stack
print_r(xdebug_get_function_stack());
#T=xdebug_print_function_stack
xdebug_print_function_stack( '----' );
#T=多个insert
insert into tg_files(tg_id,tf_path) values(2,'docs/fdsafdsfds.doc'),(2,'fdsafdsf')
#T=防止站外提交；
if(strpos($_SERVER['HTTP_REFERER'],$_SERVER['HTTP_HOST'])===false) exit();//防止站外提交；

#T=服务器信息
<?php

echo date('Y-m-d H:i:s',time()),'<br />';
echo __FILE__,'<br />';
echo dirname(__FILE__),'<br />';
echo DIRECTORY_SEPARATOR,'<br />';

define('DOCROOT', dirname(__FILE__).'/');
define('WEBROOT', 'http://'.$_SERVER["HTTP_HOST"].'/');
echo DOCROOT,'<br />';
echo WEBROOT,'<br />';

function query($sql){
$r = mysql_query($sql) or die(mysql_error());
return $r;
}

function DB($db='hyzs'){
$link = mysql_connect('localhost','root','123') or die(mysql_error());
mysql_select_db($db) or die(mysql_error());
mysql_set_charset('utf8');
return $link;
}

$link=DB();


?>

<pre>
<?php
print_r($_SERVER);
?>
</pre>
<hr />

<?php
phpinfo();
?>


#T=取得函数定义的位置
echo new \ReflectionFunction('PutCookie');
#T=取得类的方法的位置
$class = new \ReflectionClass(get_class($this));
echo $class->getMethod('set');
#T=取得类的位置和内容ReflectionClass
echo new \ReflectionClass('Cache');
#T=取得类的位置和内容-对象获取
echo new \ReflectionClass(get_class($this));
#T=添加日志文件
file_put_contents("/sql2.txt", $str."\n\r", FILE_APPEND);
#T=添加日志文件-限制大小
$log_txt = "/0log.txt";

file_put_contents($log_txt, $sql. "\n\r", FILE_APPEND);

if(filesize($log_txt)>512000) {
	unlink($log_txt);
}
#