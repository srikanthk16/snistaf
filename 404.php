<?php

require_once("models/config.php");

?>

<!DOCTYPE html>
<html lang="en">
  <?php
	echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "404 Oh Noes!"));
  ?>

  <body>
    <div class="container">
      <div class="header">
        <h3 class="text-muted">SNISTAF</h3>
      </div>
      <div class="jumbotron">
        <h1>Well dang.</h1>
        <p class="lead">We are so, so, so, sorry.  That was NOT supposed to happen.  How can we make it up to you?</p>
        <small>By the way, here's what we think might have happened:</small>
		<div class="row">
			<div id='display-alerts' class="col-sm-12">

			</div>
        </div>
      </div>
      <?php echo renderTemplate("footer.html"); ?>

    </div> <!-- /container -->

  </body>
</html>

<script>
	$(document).ready(function() {
		alertWidget('display-alerts');
	});
</script>
