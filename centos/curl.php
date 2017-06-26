<?php

/*******************************

linux下测试curl命令

在命令行下执行访问curl.php
curl -A "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)" -e "http://www.baidu.com" -d "arr[]=105&arr[name]=eric&arr[love]=girl&pid=2880&poll=投票" http://127.0.0.1/curl.php

***********************************/

function getip(){
if(getenv('HTTP_CLIENT_IP') && strcasecmp(getenv('HTTP_CLIENT_IP'), 'unknown')) $ip = getenv('HTTP_CLIENT_IP');
else if(getenv('HTTP_X_FORWARDED_FOR') && strcasecmp(getenv('HTTP_X_FORWARDED_FOR'),'unknown')) $ip = getenv('HTTP_X_FORWARDED_FOR');
else if($_SERVER['REMOTE_ADDR'] && strcasecmp($_SERVER['REMOTE_ADDR'],'unknown'))  $ip = $_SERVER['REMOTE_ADDR'];
else $ip = 'unknown';
return $ip;
}

var_dump($_SERVER['HTTP_REFERER']);


echo "\n";
echo $_SERVER['HTTP_USER_AGENT'],"\n";

echo getip(),"\n";


print_r($_POST);
print_r($_GET);
//touch("flexpager", 1306642109)


//

?>
