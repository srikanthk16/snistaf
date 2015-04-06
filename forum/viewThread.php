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
echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Subscriptions"))	;
echo renderAccountPageHeader(array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Subscriptions"));
?>
<body>
  <?php echo renderMenu	("Forum");?>
  <?php
  $tid=$_GET['id'];
$resultarray=loadThreadPosts($tid);
print_r($resultarray);?>

<table border="1">
	<thead>
		<th>Forum</th>
		<th>Posts</th>
	</thead>
	<tbody>
<?php foreach ($resultarray as $row): array_map('htmlentities', $row); ?>
    <tr>
      <td><a href="viewForum.php?id=<?php echo intval($row[0]);?>" ><?php echo $row[1]; ?></a></td>
			<td><?php echo $row[2];?></td>
    </tr>
<?php endforeach; ?>
  <tbody>
</table>

	<form name="post" action="api/createPost.php" method="get">
	<input type="hidden" name="tid" value="<?php echo $_GET['id'];?>">
	<input type="text" name="content" >
	<input type="submit" name="submit">
	</form>
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
				content:	form.find('input[name="content"]').val(),
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
					alert("success");
					window.location.replace("");
				}
				}
			});
			// Prevent form from submitting twice
			e.preventDefault();
			});

		});
	</script>
</body>
</html>
