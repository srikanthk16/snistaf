<?php
/*
SNISTAF Public Code
By Srikanth Kasukurthi
Copyright (c) 2015 for SNIST

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/
require_once("../models/config.php");
if(!isUserLoggedIn()) {
	addAlert("warning", "Login to continue!");
	apiReturnError($ajax, SITE_ROOT."login.php");
}
setReferralPage(getAbsoluteDocumentPath(__FILE__));
 ?>
<html>
<?php
echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Forum"))	;
echo renderAccountPageHeader(array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Forum"));
?>
<body>
	<div id="wrapper">
		<?php echo renderMenu("Forum");
		$fid=$_GET['id'];
		?>
    <div id="wrapper">
  		<?php echo renderMenu("Forum");
  		$fid=$_GET['id'];
  		?>
  	<div id="pagewrapper" padding-left="60px" >
  		<ol class="breadcrumb">
  		<li><a href="index.php">Home</a></li>
  		<li class="active"><a href="?id=<?php echo $fid;?>"><?php echo getForumName($fid);?></a></li>
  		</ol>
    <?php

  	$uid=$loggedInUser->user_id;
  	$resultarray=loadForumThreads($fid);
  	if(isset($_GET['page'])){
  	$offset=$_GET['page'];}
  	else
  	$offset=0;
  	$arr_length=count($resultarray);
  	$results=array_slice($resultarray,$offset*10,($offset*10)+10,true);
  //print_r($resultarray);
    ?>
  	<?php
      if(!isMod($uid,$fid)){
       addAlert("warning","you dont have permission");
        echo "You dont have permission";
        die("<script>location.href = 'index.php'</script>");
      }
  			?>
				
