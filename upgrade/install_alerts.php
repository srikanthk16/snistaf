<?php


require_once("../models/funcs.php");

session_start();

// Always a publically accessible script
if ($_SERVER['REQUEST_METHOD'] == 'POST'){
    addAlert($_POST['type'], $_POST['message']);
}

if ($_SERVER['REQUEST_METHOD'] == 'GET'){
    echo json_encode($_SESSION["userAlerts"]);

    // Reset alerts after they have been delivered
    $_SESSION["userAlerts"] = array();
}

?>
