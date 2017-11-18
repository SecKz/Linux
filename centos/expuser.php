<?php

//导出到文件 php expuser.php > user_pri.sql;
//不要复制root的pri

define('DBHOST', 'localhost');
define('DBUSER', 'root');
define('DBNAME', 'mysql');
define('DBPW', '123');


function DB()
{
	$link =  new mysqli(DBHOST, DBUSER, DBPW, DBNAME, 3306) or die(mysqli_connect_error());
	$link->set_charset('utf8');
	return $link;
}

$link = DB();

$r = mysqli_query($link, "select user,host,password from user") or die(mysqli_error());
while($row = mysqli_fetch_assoc($r)) {
	extract($row);
	$grantssql[] = "show grants for '$user'@'$host'";
}

echo "-- 不要复制root的权限\n";

foreach($grantssql as $k=>$v) {
	$r = mysqli_query($link, $v);
	//echo $v,"\n";
	if($r) {
		while($row = mysqli_fetch_row($r)) {
			echo $row[0],";\n";
		}
	}
}

?>


