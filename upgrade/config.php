<?php


// Used to force backend scripts to log errors rather than print them as output
function logAllErrors($errno, $errstr, $errfile, $errline, array $errcontext) {
	ini_set("log_errors", 1);
	ini_set("display_errors", 0);

    error_log("Error ($errno): $errstr in $errfile on line $errline");
	throw new ErrorException($errstr, 0, $errno, $errfile, $errline);
}

require_once("../models/db-settings.php");
require_once("../models/class_validator.php");
require_once("../models/password.php");
require_once("../models/db_functions.php");
require_once("../models/funcs.php");
require_once("../models/languages/en.php");
require_once("../models/class.mail.php");
require_once("../models/class.user.php");
require_once("../models/error_functions.php");
require_once("../models/secure_functions.php");

defined("MENU_TEMPLATES")
    or define("MENU_TEMPLATES", dirname(__FILE__) . "/menu-templates/");

// Construct default site path for inserting into the database
$hostname = $_SERVER['HTTP_HOST'];
$app_path = $_SERVER['PHP_SELF'];

// Get the parent directory of this (the install) directory
$app_dir_raw = dirname(dirname($app_path));

// Replace backslashes in local root (if we're in a windows environment)
$app_dir = str_replace('\\', '/', $app_dir_raw);

// Known issue with dirname: If the path is the root path, dirname will return a single slash.  Otherwise, it does not use a trailing slash. So, we need to check for this.
if ($app_dir == "/"){
    $app_dir = "";
}

$url = $hostname . $app_dir . '/';

session_start();
