<?php
/*

Srikanth Kasukurthi for SNISTAF

copyright (c) 2015

*/

require_once('../models/config.php');

// Fetch information for currently logged in user
// Parameters: none

set_error_handler('logAllErrors');

// Request method: GET
$ajax = checkRequestMode("get");

// Check that there is a logged-in user
$user_id = null;
if(isUserLoggedIn()) {
    $user_id = $loggedInUser->user_id;
} else {
    addAlert("danger", "Whoops, looks like you're not logged in!");
    apiReturnError($ajax, getReferralPage());
}

$results=isAlumni($user_id);

/*if (!$result){
    apiReturnError($ajax, getReferralPage());
}
$result['isAlumni']=$result;
$results['csrf_token'] = $loggedInUser->csrf_token;*/

restore_error_handler();

echo json_encode($results);
?>
