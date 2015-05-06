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
require_once("../../models/config.php");
if(!isUserLoggedIn()) {
	addAlert("warning", "Login to continue!");
	apiReturnError($ajax, SITE_ROOT."login.php");
}

//for fucks sake, only goku can auto create forums, other admins cant' below is code if we want all masters to do
if($loggedInUser->user_id!=1){ //isset($_SESSION["userCakeUser"]) && is_object($_SESSION["userCakeUser"]) and $_SESSION["userCakeUser"]->user_id == $master_account)
  addAlert("warning","Only Goku can autocreate");
}
setReferralPage(getAbsoluteDocumentPath(__FILE__));
 ?>
<html>
<?php
//echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Subscriptions"))	;
echo renderAccountPageHeader(array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Subscriptions"));
?>


<body>
	<div id="wrapper">
		<?php echo renderMenu("AutoCreate");
		?>
	<div id="pagewrapper" padding-left="60px" >
	<?php
  echo "Calling auto create module"
  if(!autoCreate()){
    echo "some error with auto create, please check logs";
  }
  else
  echo "auto create has done it...";
  echo "you can ask user to do/enable by default auto subscribe";
?>

	</div>

	</div>


  <?php echo renderTemplate("footer.html"); ?>
</body>
</html>
