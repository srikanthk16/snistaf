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
		?>
	<div id="pagewrapper" padding-left="60px" >
  <?php
  $fid=$_GET['id'];
	$uid=$loggedInUser->user_id;
	$resultarray=loadForumThreads($fid);
	if(isset($_GET['page'])){
	$offset=$_GET['page'];}
	else
	$offset=0;
	$results=array_slice($resultarray,$offset*10,($offset*10)+10,true);
//print_r($resultarray);
  ?>
	<?php
    if(!isSubscribed($uid,$fid)){
			?>
				<form name="forum" action="../api/createSubscription.php" method="get">
				<input type="hidden" name="uid" id="uid" value="<?php echo $uid; ?>"></input>
				<input type="hidden" name="fid" id="fid" value="<?php echo $fid; ?>"></input>
				<input type="submit" name="submit" value="subscribe"></input>
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
			<form name="forum" action="../api/createSubscription.php" method="get">
			<input type="hidden" name="fid" id="fid" value="<?php echo $fid; ?>"></input>
			<input type="text" name="name" id="name"></input>
			<input type="submit" name="submit" value="ThreadIT"></input>
		</form>
		<script>
					$(document).ready(function() {

				// Load jumbotron links
				$(".jumbotron-links").load("jumbotron_links.php");

				alertWidget('display-alerts');

				$("form[name='forum']").submit(function(e){
				var form = $(this);
				var url = '../api/createThread.php';
				$.ajax({
					type: "GET",
					url: url,
					data: {
					fid:	form.find('input[name="fid"]').val(),
					name:	form.find('input[name="name"]').val(),
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
		</thead>
		<tbody>
	<?php foreach ($results as $row): array_map('htmlentities', $row); ?>
	    <tr>
	      <td class="col-md-6"><a href="viewThread.php?id=<?php echo intval($row[0]);?>" ><?php echo $row[1]; ?></a></td>
				<td class="col-md-2"><?php echo getNameById($row[2]);?></td>
	    </tr>
	<?php endforeach; ?>
	  <tbody>
	</table>
	</div></div>
</body>
</html>
