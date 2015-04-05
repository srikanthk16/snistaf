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

// Public page

setReferralPage(getAbsoluteDocumentPath(__FILE__));
 ?>
<html>
<?php
echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Login"));
?>
<body>
	<form name="forum" action="../api/createForum.php" method="get">
		<input type="text" name="name" id="name"></input>
		<input type="text" name="description" id="description"></input>
		<input type="text" name="type" id="type"></input>
		<input type="submit" name="submit" value="submit"></input>
	</form>

	<?php echo renderTemplate("footer.html"); ?>

	<script>
				$(document).ready(function() {

			// Load jumbotron links
			$(".jumbotron-links").load("jumbotron_links.php");

			alertWidget('display-alerts');

			$("form[name='forum']").submit(function(e){
			var form = $(this);
			var url = '../api/createForum.php';
			$.ajax({
				type: "GET",
				url: url,
				data: {
				name:	form.find('input[name="name"]').val(),
				description:	form.find('input[name="description"]').val(),
				type: form.find('input[name="type"]').val(),
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
					window.location.replace("subscriptions.php");
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
