<?php

//导出到文件 php expuser.php > user_pri.sql;
//不要复制root的pri

define('DBHOST', 'localhost');
define('DBUSER', 'root');
define('DBNAME', 'mysql');
define('DBPW', '123');

function DB($db=DBNAME){
$link = mysql_connect(DBHOST, DBUSER, DBPW) or die(mysql_error());
mysql_select_db($db) or die(mysql_error());
mysql_set_charset('utf8');
return $link;
}

$link = DB();

$r = mysql_query("select user,host,password from user") or die(mysql_error());
while($row = mysql_fetch_assoc($r)) {
extract($row);
$grantssql[] = "show grants for '$user'@'$host'";
}

echo "-- 不要复制root的权限\n";

foreach($grantssql as $k=>$v) {
$r = mysql_query($v);
//echo $v,"\n";
if($r) {
while($row = mysql_fetch_row($r)) {
echo $row[0],";\n";
}
}
}

?>


