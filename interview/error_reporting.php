<?php
$mtime = microtime(true);

?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>error_reporting</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<style type="text/css">
*{list-style:none;font-size:14px;font-family:tahoma;}
#content{width:1300px;height:500px;font-size:12px;padding:3px;}
</style>
</head>
<body>

<pre>
error_reporting(0);

// Report simple running errors
error_reporting(E_ERROR | E_WARNING | E_PARSE);

// Reporting E_NOTICE can be good too (to report uninitialized
// variables or catch variable name misspellings ...)
error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);

// Report all errors except E_NOTICE
// This is the default value set in php.ini
error_reporting(E_ALL ^ E_NOTICE);

// Report all PHP errors (see changelog)
error_reporting(E_ALL);
error_reporting(-1);

// Same as error_reporting(E_ALL);
ini_set('error_reporting', E_ALL);

</pre>

<form method="post" action="" id="uploadform" enctype="multipart/form-data">

</form>

<hr />


<pre>


<?php

error_reporting(1);
error_reporting(0);

echo $a;

?>


</pre>

</body>
</html>

