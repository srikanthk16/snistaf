<?php
require_once("../models/config.php");
$uid=$_GET['id'];
$image=displayImage($uid);
header('Content-Type: image/png');
echo $image;
?>
