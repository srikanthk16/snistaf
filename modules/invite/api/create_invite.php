<?php
/*

UserFrosting Version: 0.2.1 (beta)
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

require_once("../../../models/config.php");
require_once("../models/invite_funcs.php");


set_error_handler('logAllErrors');

if (!isUserLoggedIn()){
    addAlert("danger", "You must be logged in to access this resource.");
    echo json_encode(array("errors" => 	1, "successes" => 0));
    exit();
}

$validator = new Validator();
// Required: csrf_token, user_id, email
$csrf_token = $validator->requiredPostVar('csrf_token');
$user_id = $validator->requiredNumericPostVar('user_id');
$email = str_normalize($validator->requiredPostVar('email'));
$message = trim($validator->optionalPostVar('message'));
$name = trim($validator->requiredPostVar('name'));




// Add alerts for any failed input validation
foreach ($validator->errors as $error){
  addAlert("danger", $error);
}

// Validate csrf token
if (!$csrf_token or !$loggedInUser->csrf_validate(trim($csrf_token))){
	addAlert("danger", lang("ACCESS_DENIED"));
    echo json_encode(array("errors" => 1, "successes" => 0));
	exit();
}

// Special case to update the logged in user (self)
$self = false;
if ($user_id == "0"){
	$self = true;
	$user_id = $loggedInUser->user_id;
}

//Check if selected user exists
if(!$user_id or !userIdExists($user_id)){
	addAlert("danger", "I'm sorry, the user id you specified is invalid!");
	if (isset($_POST['ajaxMode']) and $_POST['ajaxMode'] == "true" ){
	  echo json_encode(array("errors" => 1, "successes" => 0));
	} else {
	  header("Location: " . getReferralPage());
	}
	exit();
}
	
$userdetails = fetchUserAuthById($user_id); //Fetch user details

$error_count = 0;
$success_count = 0;



// **************** Create invite here ****************

//todo Check if inviter has unused invites
$invitesLeft =  invitesLeft($user_id);
//check if email exist in user table
$userExist = emailExists($email);
if (($invitesLeft>0) & (!$userExist))
{

	//create unique token
	$token=getUniqueCode(32);
	//create invite table entry (email,name,  token, inviterId, status)
	createInvite($user_id,$email,$message,$token);
	//decrease inviterIds invite count

	//create email
	$mail = new userCakeMail();					
	$invite_url = SITE_ROOT."/modules/invite/invite_register.php?token=".$token;
	
	//Setup our custom hooks
	$hooks = array(
		"searchStrs" => array("#INVITATION-URL","#NAME#","#SITENAME#", "#INVITERNAME#"),
		"subjectStrs" => array($invite_url,$name,$websiteName,$userdetails['display_name'] )
	);
	if(!$mail->newTemplateMsg("new-invitation.txt",$hooks))
	{
		$errors[] = lang("MAIL_TEMPLATE_BUILD_ERROR");
	}
	else
	{
		
		if (!$mail->sendMail($email,"You are invited to ".$websiteName))
		{
			$errors[] = lang("MAIL_ERROR");
		}
		else
		{
			//Success, user details have been updated in the db now mail this information out.
			$successes[] = lang("ACCOUNT_NEW_INVITATION_SENT");
			//addAlert("danger", "Your email has been sent!");
		}
	}	
	//send email
}	
else
{
 if ($invitesLeft<1) 
 	addAlert("danger", "I'm sorry, you don't have any invites left!");
 if ($userExist) 
 	addAlert("danger", "A user with that email allready exist");
}


// **************** END Create invote here ****************


restore_error_handler();

$ajaxMode = $validator->optionalBooleanPostVar('ajaxMode', 'true');


if ($ajaxMode == "true" ){
  echo json_encode(array(
	"errors" => $error_count,
	"invitesLeft" => $invitesLeft,
	"successes" => $success_count));
} else {
  header('Location: ' . getReferralPage());
  exit();
}

?>
	