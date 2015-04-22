<?php
require_once("../models/config.php");
$uid=$_GET['id'];
$image=displayImage($uid);
if($image==null){
  $image=file_get_contents("default.png"); 
}
header('Content-Type: image/png');
echo $image;
?>
