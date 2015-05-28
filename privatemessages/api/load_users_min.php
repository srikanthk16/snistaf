<?php
/**
 * Srikanth
 * test changes to fix private messages
 */

require_once('../../models/config.php');
require_once('../models/pm_functions.php');

set_error_handler('logAllErrors');

// Request method: GET
$ajax = checkRequestMode("get");

// User must be logged in
checkLoggedInUser($ajax);

// GET Parameters: [user_id, group_id, limit]
// If a user_id is specified, attempt to load information for the specified user (self if set to 0).
// If a group_id is specified, attempt to load information for all users in the specified group.
// Otherwise, attempt to load all users.
$validator = new Validator();
$limit = $validator->optionalGetVar('limit');
$user_id = $validator->optionalGetVar('user_id');
$group_id = $validator->optionalGetVar('group_id');

// Add alerts for any failed input validation
foreach ($validator->errors as $error){
    addAlert("danger", $error);
}

if (count($validator->errors) > 0){
    apiReturnError($ajax, getReferralPage());
}

if ($user_id){
    // Special case to load groups for the logged in user
    if ($user_id == "0"){
        $user_id = $loggedInUser->user_id;
    }
    if (!$results = fetchUser($user_id)) {
        apiReturnError($ajax, getReferralPage());
    }
} else if ($group_id) {
    if (!$results = loadUsersInGroup($group_id)) {
        apiReturnError($ajax, getReferralPage());
    }
} else{
	if (!$results = loadUsersMinimal($limit)) {
		apiReturnError($ajax, getReferralPage());
	}
}
restore_error_handler();

echo json_encode($results);
?>
