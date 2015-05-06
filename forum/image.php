<?php
require_once("../models/config.php");
$id=$_GET['id'];
$image=displayPostImage($id);
if($image==null){
//no image
}
else{
header('Content-Type: image/png');
echo $image;}
?>
