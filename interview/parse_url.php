<!DOCTYPE html>
<html>
<head>

<title>parse_url</title>
<style type="text/css">
*{list-style:none;font-size:14px;font-family:tahoma;}
</style>

</head>
<body>
<xmp>

</xmp>
 <hr />

<pre>

<?php
$url="http://localhost/all/php/test1.php?name=eric&page=1" ;
$arr=parse_url($url);
print_r($arr);

print_r(pathinfo($url));


?>

</pre>

</body></html>





















