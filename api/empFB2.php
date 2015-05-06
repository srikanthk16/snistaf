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
$ajax = checkRequestMode("get");
//error_log($ajax);
/*if(!isUserLoggedIn()) {
	addAlert("warning", "Login to continue!");
	apiReturnError($ajax, SITE_ROOT."login.php");
}*/
/*if (!securePage(__FILE__)){
    apiReturnError($ajax);
}
*/
setReferralPage(getAbsoluteDocumentPath(__FILE__));
//$user_id=$loggedInUser->user_id;
//print $user_id;
$validator = new Validator();
$uid = $validator->requiredGetVar('uid');
$ansarray=array();
foreach ($_GET as $key => $val){
  if($val==$_GET['uid']){
    continue;
  }
  array_push($ansarray,$val);
/*  $ansarray[0]=$validator->requiredGetVar('a');
  $ansarray[1]=$validator->requiredGetVar('b');
  $ansarray[2]=$validator->requiredGetVar('c');
  $ansarray[3]=$validator->requiredGetVar('d');*/
  //error_log(implode(" ",$ansarray));
}
//$a = $validator->optionalGetVar('a');
//print $name;
if(!addEMPFB2($uid,$ansarray)){
  addAlert("warning", "Feedback Error!");
  apiReturnError($ajax, SITE_ROOT);
}
apiReturnSuccess($ajax, getReferralPage());
print "success";
?>
