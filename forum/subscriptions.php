<?php
require_once("../models/config.php");
if(!isUserLoggedIn()) {
	addAlert("warning", "Login to continue!");
	apiReturnError($ajax, SITE_ROOT."login.php");
}
setReferralPage(getAbsoluteDocumentPath(__FILE__));
$user_id=$loggedInUser->user_id;
$resultarray=loadSubscriptions($user_id);
 ?>
<html>
<?php
echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Login"));
?>
<body>
<?php
print_r($resultarray); ?>
  <?php echo renderTemplate("footer.html"); ?>
</body>
</html>
