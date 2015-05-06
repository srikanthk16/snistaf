<?php
/*
SNISTAF API
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
//error_log(checkRequestMode("POST"));
$ajax = checkRequestMode("POST");
//error_log($ajax);
if(!isUserLoggedIn()) {
	addAlert("warning", "Login to continue!");
	apiReturnError($ajax, SITE_ROOT."login.php");
}
/*if (!securePage(__FILE__)){
    apiReturnError($ajax);
}
*/
setReferralPage(getAbsoluteDocumentPath(__FILE__));
$user_id=$loggedInUser->user_id;
//print $user_id;
$validator = new Validator();
$threadid = $validator->requiredPostVar('tid');
$content = $validator->requiredPostVar('content');
//$iid=$validator->optionalPostVar('iid');
//$content.='<img height="100" width="100" src="image.php?id='.$iid.'"></img>';
if(isset($_FILES['userImage'])){
if(is_array($_FILES)) {
if(is_uploaded_file($_FILES['userImage']['tmp_name'])) {

$sourcePath = $_FILES['userImage']['tmp_name'];
$image=file_get_contents(addslashes($sourcePath));
$id=addPostImage($image);
$targetPath = "../forum/images/".$_FILES['userImage']['name'];
if($id) {
//return $id;
$content.='<img src="image.php?id='.$id.'" width="100px" height="100px" />';

}

}
}}
//error_log($content);
//$im=$validator->optionalPostVar('image');
if(isset($_POST['status'])){
	$status=$validator->optionalPostVar('status');
	if(!addHDPost($user_id,$threadid,$content,$status)){
		print "unknown error";
		apiReturnError($ajax, SITE_ROOT);

	}
	apiReturnSuccess($ajax, getReferralPage());

}
error_log($content);
if(!addPost($user_id,$threadid,$content)){
  print "unknown error";
  apiReturnError($ajax, SITE_ROOT);
}

apiReturnSuccess($ajax, getReferralPage());
print "success";
?>
