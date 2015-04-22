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
    if(!isSubscribed($uid,$fid)){
			?>
				<form name="forum" action="../api/createSubscription.php" method="get">
				<input type="hidden" name="uid" id="uid" value="<?php echo $uid; ?>"></input>
				<input type="hidden" name="fid" id="fid" value="<?php echo $fid; ?>"></input>
				<input type="submit" name="submit" class="btn btn-primary" value="subscribe"></input>
			</form>

			<script>
						$(document).ready(function() {

					// Load jumbotron links
					$(".jumbotron-links").load("jumbotron_links.php");

					alertWidget('display-alerts');

					$("form[name='forum']").submit(function(e){
					var form = $(this);
					var url = '../api/createSubscription.php';
					$.ajax({
						type: "GET",
						url: url,
						data: {
						uid:	form.find('input[name="uid"]').val(),
						fid:	form.find('input[name="fid"]').val(),
						ajaxMode:	"true"
						},
						success: function(result) {
						var resultJSON = processJSONResult(result);
						if (resultJSON['errors'] && resultJSON['errors'] > 0){
							alertWidget('display-alerts');
						} else {
							/*window.location.replace("");
							alertWidget('success');*/
							//alert("success");
							window.location.replace("");
						}
						}
					});
					// Prevent form from submitting twice
					e.preventDefault();
					});

				});
			</script>
			<?php
		}
		else{
			?>

		<!-- Modal -->
		<div class="modal fade" id="postModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header"> <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">Create Post</h4>
		      </div>
		      <div class="modal-body">
			<form name="thread" action="../api/createThread.php" method="get">
			<input type="hidden" name="fid" value="<?php echo $fid;?>">
			<label for="name">Name:</label>
			<textarea type="text" class="form-control" name="name" form="thread" rows="2"></textarea>
			<label for="content">Post:</label>
			<textarea type="text" class="form-control" name="content" form="thread" rows="5"></textarea>
		</div>
			<div class="modal-footer">
				<input type="submit" name="submit" class="btn btn-default" >
				</form>
				</div>
			</div>
		</div>
		</div>

		<script>
					$(document).ready(function() {

				// Load jumbotron links
				$(".jumbotron-links").load("jumbotron_links.php");

				alertWidget('display-alerts');

				$("form[name='thread']").submit(function(e){
				var form = $(this);
				var url = '../api/createThread.php';
				$.ajax({
					type: "GET",
					url: url,
					data: {
					fid:	form.find('input[name="fid"]').val(),
					name:	form.find('textarea[name="name"]').val(),
					content: form.find('textarea[name="content"]').val(),
					ajaxMode:	"true"
					},
					success: function(result) {
					var resultJSON = processJSONResult(result);
					if (resultJSON['errors'] && resultJSON['errors'] > 0){
						alertWidget('display-alerts');
					} else {
						/*window.location.replace("");
						alertWidget('success');*/
						//alert("success");
						window.location.replace("");
					}
					}
				});
				// Prevent form from submitting twice
				e.preventDefault();
				});

			});
		</script>
			<?php
		}
	?>

	<table class="table">
		<thead>
			<th class="col-md-6">Thread</th>
			<th class="col-md-2">Added by</th>
			<th class="col-md-2">Posts</th>
			<th class="col-md-2">Views</th>
		</thead>
		<tbody>
	<?php foreach ($results as $row): array_map('htmlentities', $row); ?>
	    <tr>
	      <td class="col-md-6"><a href="viewThread.php?id=<?php echo intval($row[0]);?>" ><?php echo $row[1]; ?></a><?php if($row[4]){echo "-sticked";
				} ?></td>
				<td class="col-md-2"><?php echo getNameById($row[2]);?></td>
				<td class="col-md-2"><?php echo getPostsNumber(intval($row[0]));?></td>
				<td class="col-md-2"><?php echo getviewsNumber(intval($row[0]));?></td>
	    </tr>
	<?php endforeach; ?>
	  <tbody>
	</table>
	<div class="inline">
	<button type="button" class="btn btn-primary btn-small pull-left" data-toggle="modal" data-target="#postModal">
	Create Thread
	</button>

	<button type="button" class="btn btn-primary btn-small pull-right" data-toggle="modal" data-target="#postModal">
	Create Thread
</button>
<ul class="pager">
<li>	<a href="?id=<?php echo $fid;?>&page=<?php echo $offset==0?0:$offset-=1;?>" class="btn btn-info" role="button"><span class="fa fa-angle-left" aria-hidden="true" ></span></a>
</li><li>	<a href="?id=<?php echo $fid;?>&page=<?php echo $offset*10<$arr_length?$offset:$offset+=1;?>" ><span class="fa fa-angle-right" aria-hidden="true"></span></a>
</li></ul></div>

	</div></div>
</body>
</html>
