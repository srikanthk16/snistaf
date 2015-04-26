<?php
require_once("../models/config.php");
if(is_array($_FILES)) {
if(is_uploaded_file($_FILES['userImage']['tmp_name'])) {

$sourcePath = $_FILES['userImage']['tmp_name'];
$image=base64_encode(file_get_contents(addslashes($sourcePath)));
$id=addPostImage($image);
$targetPath = "../forum/images/".$_FILES['userImage']['name'];
if($id) {
//return $id;
echo '<img src="<?php echo $targetPath;?>" width="100px" height="100px" />';

}

}
}
?>
