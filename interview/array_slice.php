
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>array_slice</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<style type="text/css">
*{list-style:none;font-size:14px;font-family:tahoma;}
#content{width:1300px;height:500px;font-size:12px;padding:3px;}
</style>
</head>
<body>

<pre>
array_slice
</pre>

<form method="post" action="" id="uploadform" enctype="multipart/form-data">

</form>

<hr />


<pre>


<?php
var_dump($a=$b);

$input = array("a", "b", "c", "d", "e");

print_r(array_slice($input, 2));      // returns "c", "d", and "e"
print_r(array_slice($input, -2, 1));  // returns "d"
print_r(array_slice($input, 0, 3));   // returns "a", "b", and "c"

// note the differences in the array keys
print_r(array_slice($input, 2, -1));
print_r(array_slice($input, 2, -1, true));

?>


</pre>

</body>
</html>

