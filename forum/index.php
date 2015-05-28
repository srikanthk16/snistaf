<?php /*stub until we build a strong notification system which shows all the recent notifications here
until then user will be redirected to subscriptions */ ?>

<?php
require_once("../models/config.php");
if(!isUserLoggedIn()) {
	addAlert("warning", "Login to continue!");
	apiReturnError($ajax, SITE_ROOT."login.php");
}
$user_id=$loggedInUser->user_id;
if(doneLanding($user_id)=='1'){
  header("Location: subscriptions.php");
}
else
header("Location: landing.php");
?>
