<?php
/*

SNIST Feedback System
by Srikanth Kasukurthi and Mohan Kumar Bhupathi
Copyright (c) 2015 for SNIST


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

// Public page

setReferralPage(getAbsoluteDocumentPath(__FILE__));
if(!isUserLoggedIn()) {
  $email=$_GET['email'];
  $authKey=$_GET['authKey'];
  $auth=getOtherUserAuthId($email,$authKey);
  if($auth['group']=='0')
  $type=7;
  else
  $type=6;
  print_r($type);
	$fbsession=feedbackSession($auth['id'],1,$type);
  $url="?email=".$email."&key=".$authKey;
}
else
{
  $uid=$loggedInUser->user_id;
  $fbsession=feedbackSession($uid,0,5);
  //print_r($fbsession);
}
?>
<!DOCTYPE html>
<html lang="en">
  <?php
	echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Feedback"));
  ?>

<body>
  <div class="row">
<div class="well well-sm custom-well-small">
<fieldset>
            <legend> <br>
Select a option. </legend>
          <h4>

  </h4>
</fieldset>
</div>
<div class="well well-sm custom-well-small">
  <form class="form-inline" name="al1" method="get" action="../api/pollFB.php">

      <fieldset>
        <?php $resultArray=loadFeedbackQuestions(11);
        //print_r($resultArray);
        $title=getFeedbackTitle(11);
         ?>
         <h1><?php echo $title; ?></h1>
        <?php foreach ($resultArray as $row): array_map('htmlentities', $row); ?>
          <div class="inline">
            <div id="rad" name="rad">
          <span class="pull-left row-fluid"><?php echo $row['question']; ?></span></br>
        <?php	$ansArr=loadFeedbackAnswers($row['id']);?>

          <?php foreach($ansArr as $val): array_map('htmlentities',$val);?>
            <label class="radio-inline center">
<input type="radio" name="<?php echo $row['id'];?>" id="inlineRadio" value="<?php echo $val['id']; ?>"> <?php echo $val['options']; ?>
</label>


        <?php endforeach; ?>
      </br></br></div></div>
    <?php endforeach; ?>
      <div class="inline">
        <input type="hidden" name="tid" value="11">

        <input type="submit" class="btn btn-primary pull-right" value="Next" name="submit"></div>
  </form></div>
  <div class="well well-sm custom-well-small">
    <span id="text"></span>
</div>

  <br>
  <br>
<script>
function textMode(){
  var form = $(this);
  var url = '../api/loadPollFB.php';
  var serializedData = form.serialize();
  serializedData += '&ajaxMode=true';
  $.ajax({
    type: "GET",
    url: url,
    data: serializedData,
    success: function(result) {
    var resultJSON = processJSONResult(result);
    //alert(JSON.stringify(resultJSON));
    if (resultJSON['errors'] && resultJSON['errors'] > 0){
      alertWidget('display-alerts');
      alert(" Fill details or enter correct details");
    } else {
      var str="Feedback Data </br></br>";
$.each(resultJSON,function(key,val){

  if(val.options!=null){
    if(val.count!=null){
  str=str.concat(String(val.options));
  str=str.concat("&nbsp;&nbsp;=&nbsp;&nbsp;");
  str=str.concat(String(val.count));
  str=str.concat("</br>");}}
});

      document.getElementById('text').innerHTML=str;
    }
    }
  });
}
      $(document).ready(function() {
    // Load navigation bar
    // Load jumbotron links
    $(".jumbotron-links").load("jumbotron_links.php");
    alertWidget('display-alerts');

    $("form[name='al1']").submit(function(e){
    var form = $(this);
    if ($('div.rad:not(:has(:radio:checked))').length) {
    alert("At least one question is blank");
}
    var url = '../api/pollFB.php';
    var serializedData = form.serialize();
    serializedData += '&ajaxMode=true';
    $.ajax({
      type: "GET",
      url: url,
      data: serializedData,
      success: function(result) {
      var resultJSON = processJSONResult(result);
      //alert(JSON.stringify(resultJSON));
      if (resultJSON['errors'] && resultJSON['errors'] > 0){
        alertWidget('display-alerts');
        alert(" Fill details or enter correct details");
      } else {
        $('input[name="<?php echo $row['id']; ?>"]').attr('disabled', 'disabled');
        //window.location.replace("");//reload page to get new form
      }
      }
    });
    // Prevent form from submitting twice
    e.preventDefault();
    });


  });
</script></div>
</body>
</html>
