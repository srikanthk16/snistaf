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
echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Thread"))	;
echo renderAccountPageHeader(array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Thread"));
?>
<body>
	<div id="wrapper">
		<?php echo renderMenu("Forum");
		?>
	<div id="pagewrapper" padding-left="60px" >
  <?php echo renderMenu	("Forum");?>
  <?php
  $tid=$_GET['id'];
	$fid=getParentForum($tid);
	addThreadStatsViews($tid);
$resultarray=loadThreadPosts($tid);
if(isset($_GET['page'])){
$offset=$_GET['page'];}
else
$offset=0;
$arr_length=count($resultarray);
$results=array_slice($resultarray,$offset*10,($offset*10)+10,true);
//print_r($results);
//print_r($resultarray);?>
<div id="pagewrapper" padding-left="60px" >
	<ol class="breadcrumb">
	<li><a href="index.php">Home</a></li>
	<li ><a href="viewForum.php?id=<?php echo $fid;?>"><?php echo getForumName($fid);?></a></li>
	<li class="active"><a href="?id=<?php echo $tid;?>"><?php echo getThreadName($tid);?></a></li>
	</ol>

<!-- Modal -->
<table class="table table-responsice">
	<tbody>
<?php foreach($results as $row): array_map('htmlentities',$row); ?>


    <tr >
			<td class="col-md-1">


        <img src="../account/image.php?id=<?php echo $row['added_by']; ?>" width="60px" height="60px" alt="DP" class="img-responsive">
                <figcaption><?php echo getDisplayNameById($row['added_by']); ?>
								</br><?php echo getTitleById($row['added_by']); ?></figcaption>

      </td>
<td class="col-md-12 ">


        <p><?php echo $row['content']; ?></p>

</td></tr>
<?php endforeach; ?></tbody></table>
<div class="modal fade" id="postModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header"> <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Create Post</h4>
      </div>
      <div class="modal-body">
	<form name="post" class="form-group" action="../api/createPost.php" method="get">
	<input type="hidden" name="tid" value="<?php echo $_GET['id'];?>">
	<textarea class="form-control" form="post" rows="3" name="content"></textarea>
</div>
	<div class="modal-footer">
		<input type="submit" name="submit" class="btn btn-default" >
		</form>
		</div>
	</div>
</div>
</div>
<button type="button" class="btn btn-primary btn-small pull-left"  data-toggle="modal" data-target="#postModal">
Post To Thread
</button>
<ul class="pager">
<li>	<a href="?id=<?php echo $tid;?>&page=<?php echo $offset==0?0:$offset-=1;?>" class="btn btn-info" role="button"><span class="fa fa-angle-left" aria-hidden="true" ></span></a>
</li><li>	<a href="?id=<?php echo $tid;?>&page=<?php echo $offset*10<$arr_length?$offset:$offset+=1;?>" class="btn btn-info" role="button"><span class="fa fa-angle-right" aria-hidden="true"></span></a>
</li></ul>
	<script>
				$(document).ready(function() {

			// Load jumbotron links
			$(".jumbotron-links").load("jumbotron_links.php");

			alertWidget('display-alerts');

			$("form[name='post']").submit(function(e){
			var form = $(this);
			var url = '../api/createPost.php';
			$.ajax({
				type: "GET",
				url: url,
				data: {
				content:	form.find('textarea[name="content"]').val(),
				tid:	form.find('input[name="tid"]').val(),
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
	</script></div></div>
</body>
</html>
