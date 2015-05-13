<?php
/*

UserFrosting Version: 0.2.2
By Alex Weissman
Copyright (c) 2014

Based on the UserCake user management system, v2.0.2.
Copyright (c) 2009-2012

UserFrosting, like UserCake, is 100% free and open-source.

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
set_error_handler('logAllErrors');

// Request method: POST
$ajax = checkRequestMode("post");

// User must be logged in
checkLoggedInUser($ajax);



$user_id=0;
if ($user_id == "0"){
	$self = true;
	$user_id = $loggedInUser->user_id;
}

if(isset($_FILES)){
                  /*  if(getimagesize($_FILES['image']['tmp_name']) == FALSE)
                    {
                    $image=NULL;
                    }
                    else
                    {*/
                    $image= addslashes($_FILES['image']['tmp_name']);
                    //print_r($image);
                    $imagename= addslashes($_FILES['image']['name']);
                    $image= file_get_contents($image);
                    $image= base64_encode($image);
                    //print_r($image);
                    //print_r("</br>".$user_id." ".$imagename);
                    if(addImage($user_id,$imagename,$image)){

                    }
                    else{
                      apiReturnError($ajax,SITE_ROOT);
                    }

                //}
}

restore_error_handler();


    apiReturnSuccess($ajax, getReferralPage());


?>
