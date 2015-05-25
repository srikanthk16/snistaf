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
echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Profile"))	;
echo renderAccountPageHeader(array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Profile"));
?>
<body>
	<div id="wrapper">
		<?php echo renderMenu("Dashboard");
		?>
	<div id="pagewrapper" padding-left="60px" >
		<ol class="breadcrumb">
		<li><a href="index.php">Home</a></li>
		<li class="active"><a href="#">Profile</a></li>
		</ol>
  <?php

	$luid=$loggedInUser->user_id;
	if(isset($_GET['id'])){
	$uid=$_GET['id'];}
	else
	$uid=$luid;
  $image=displayImage($uid);
  $name=getNameById($uid);
  $displayname=getDisplayNameById($uid);
  $title=getTitleById($uid);
  $noOfThreads=getThreadCountById($uid);
  $noOfPosts=getPostCountById($uid);
	$details=fetchUserDetails($uid);
	$department=getDepartmentName($details[0]['department']);
	$rollno=$details[0]['roll_no'];
	$section=$details[0]['section'];
	$yearJoined=$details[0]['year_join'];
	$yearEnd=$details[0]['year_end'];

	//print_r($details);
//print_r($resultarray);
  ?>
<?php /*	<div class="inline">
  <div class="col-sm-2"><img title="<?php echo $name; ?>" class="img-circle img-responsive" src='image.php?id=<?php echo $uid;?>'>
</div>
<div class="col-sm-2">

	<div class="text-left lead">
	<?php echo $name;?></br></div>
	<div class="text-left">
	<?php echo $title;?></br>
	<?php echo $displayname;?></br>
	Karma: <?php echo "No of posts: ".$noOfPosts;?>
	</div>
</div>
</div>
*/?>
<div class="[ col-sm-6 col-md-offset-2 col-md-4 ]">
				<div class="[ info-card ]">
					<img style="width: 100%" src="image.php?id=<?php echo $uid;?>" />
					<div class="[ info-card-details ] animate">
						<div class="[ info-card-header ]">
							<h1><?php echo $name; ?></h1>
							<h3> aka <?php echo $displayname;?> </h3>
						</div>
						<div class="[ info-card-detail ]">
							<!-- Description -->
							<p><?php echo $displayname;?> is a outstanding member of snistaf at user level "<?php echo $title;?>"</br> His/Her Threads Started are <?php echo $noOfThreads;?> and Posts sharead are <?php echo $noOfPosts;?></p>

						</div>
					</div>
				</div>
</div>
<?php echo "Department: ".$department."-".$section;?>
</br>
<?php echo "Roll NO: ".$rollno; ?>
</br>
<?php echo "Batch : ".$yearJoined."-".$yearEnd; ?>
	</div></div>
</body>
</html>
