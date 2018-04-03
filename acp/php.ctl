#TITLE=PHP
#SORT=y

#T=file_put_contents
file_put_contents(^!,s)
#T=header('Content-Type:text/html;charset=UTF-8');
header('Content-Type:text/html;charset=UTF-8');

#T=header_cache
$time=gmdate('D,d M Y H:i:s',time()+60);
header ("Expires: $time GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
header('Cache-Control: max-age=60');
#T=header_Content-Type
header('Content-Type:text/html;charset=UTF-8');
#T=header_location
header('Location:^!'); exit;
#T=header_no_cache
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
header("Cache-Control: no-cache, must-revalidate");
header("Pragma: no-cache");
#T=htmlspecialchars
htmlspecialchars(^!,ENT_QUOTES)
#T=iconv('GBK','UTF-8//IGNORE',$s)
iconv('GBK','UTF-8//IGNORE',^!)
#T=iconv('GBK','UTF-8//TRANSLIT',^!);
iconv('GBK','UTF-8//TRANSLIT',^!);
#T=ini_get('include_path');
ini_get(^!);
#T=mb_strlen(s,'utf-8')
mb_strlen('^!','utf-8')
#T=mb_substr(^!, 0, 250, 'utf8')
mb_substr(^!, 0, 250, 'utf8')
#T=mysql_affected_rows
mysql_affected_rows();
#T=mysql_close
mysql_free_result($result);
mysql_close($link);
#T=str_replace
str_replace(^!,r,s)
#T=strlen
strlen(^!)
#T=substr
substr(^!,s,l)
#T=try
try {
throw new Exception('Value must be 1 or below',42);
}
catch(Exception $e) {
echo $e->getMessage();
}

#