<?php
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
