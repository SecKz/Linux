<?php
/* This section can be removed if you would like to reuse the PHP example outside of this PHP sample application */
//require_once("lib/config.php");
//require_once("lib/common.php");

//$configManager = new Config();

/*******************************
访问方法
flexpager/0.php?doc=某变电站火灾后加固处理方案的研究.pdf
***********************************/


?>

<!doctype html>
<head>
<title>FlexPaper</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />

<style type="text/css" media="screen">
html, body	{ height:100%; }
body { margin:0; padding:0; overflow:auto; }
body{overflow:hidden;}
#flashContent { display:none; }
#bbox{margin:10px 20px;}
#documentViewer{margin:20px auto;width:1200px;height:95%;}
</style>

<link rel="stylesheet" type="text/css" href="css/flexpaper.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.extensions.min.js"></script>
<script type="text/javascript" src="js/flexpaper.js"></script>
<script type="text/javascript" src="js/flexpaper_handlers.js"></script>
</head>
<body>


<?php

$doc = 'Paper.pdf';
if($_GET['doc']) {
$doc = $_GET['doc'];
}

?>

<div id="documentViewer" class="flexpaper_viewer"></div>

<script type="text/javascript">
function getDocumentUrl(document){
return "php/services/view.php?doc={doc}&format={format}&page={page}&subfolder=<?php echo $_GET["subfolder"] ?>".replace("{doc}",document);
}

var startDocument = "<?php echo $doc ?>";

$('#documentViewer').FlexPaperViewer({
config : {
DOC : escape(getDocumentUrl(startDocument)),
Scale : 0.6,
ZoomTransition : 'easeOut',
ZoomTime : 0.5,
ZoomInterval : 0.1,
FitPageOnLoad : true,
FitWidthOnLoad : true,
FullScreenAsMaxWindow : false,
ProgressiveLoading : true,
MinZoomSize : 0.2,
MaxZoomSize : 5,
SearchMatchAll : false,
InitViewMode : 'Portrait',  //Portrait
StartAtPage : '1',
RenderingOrder : 'flash,html5',
ViewModeToolsVisible : true,
ZoomToolsVisible : true,
NavToolsVisible : true,
CursorToolsVisible : true,
SearchToolsVisible : true,
JSONDataType : 'jsonp',
WMode : 'transparent',
localeChain: 'zh_CN'
}}
);


</script>
</body>
</html>