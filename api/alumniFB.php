<?php
/*
SNISTAF API
By Srikanth Kasukurthi
Copyright (c) 2015 for SNIST


Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in athe Software without restriction, including without limitation the rights
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

/*if (!securePage(__FILE__)){
    apiReturnError($ajax);
}
*/
setReferralPage(getAbsoluteDocumentPath(__FILE__));
//$user_id=$loggedInUser->user_id;
$validator = new Validator();
$tid = $validator->requiredGetVar('tid');
$sessionid=$validator->requiredGetVar('session');
$ansarray=array();
foreach ($_GET as $key => $val){
	$keys=array_search($val,$_GET);
//print_r(intval($keys));
  if($val==$_GET['tid']||$val==$_GET['session']||$val==$_GET['ajaxMode']){
    continue;
  }
  if(!rating($sessionid,$tid,$key,$val)){
    print $key."unknown error".$val;
  apiReturnError($ajax, SITE_ROOT);
  }
}
//$nextTemplate=loadTemplates($sessionid,$tid);
//print_r($nextTemplate);
if(loadTemplates($sessionid,$tid))
apiReturnSuccess($ajax, getReferralPage());
else
apiReturnError($ajax, SITE_ROOT);
print "success";
?>
