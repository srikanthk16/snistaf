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
  $authKey=$_GET['key'];
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
<?php
//echo isFeedbackDone($fbsession['id']);
if(intval(isFeedbackDone($fbsession['id']))==1){
  addAlert("warning", "You're great, since giving feedback once is itself pain");
  echo '<script>alert("feedback is noted");window.location.replace("../index.php");</script>';
}
?>
<div class="well well-sm custom-well-small">
<fieldset>
            <legend>Rank-Guidance for feedback: <br>
Please give your opinion as stated below for all the items given here under . </legend>
          <h4>
          <ul class="list-inline" id="ranks">
	<li>Very Good:5</li>
	<li>Good:4</li>
	<li>Average:3</li>
	<li>Satisfactory:2</li>
	<li>Not so satisfactory:1</li>
</ul>
  </h4>
</fieldset>
</div>
<div class="well well-sm custom-well-small">
  <form class="form-inline" name="al1" method="get" action="../api/alumniFB.php">

      <fieldset>
        <?php $resultArray=loadFeedbackQuestions($fbsession['status']);
        //print_r($resultArray);
        $title=getFeedbackTitle($fbsession['status']);
         ?>
         <h1><?php echo $title; ?></h1>
        <?php foreach ($resultArray as $row): array_map('htmlentities', $row); ?>
          <div class="inline">
            <div id="rad" name="rad">
          <span class="pull-left row-fluid"><?php echo $row['question']; ?></span></br>
        <?php	$ansArr=loadFeedbackAnswers($row['id']);?>

          <?php foreach($ansArr as $val): array_map('htmlentities',$val);?>
            <label class="radio-inline center">
<input type="radio" name="<?php echo $row['id']; ?>" id="inlineRadio" value="<?php echo $val['options']; ?>"> <?php echo $val['options']; ?>
</label>


        <?php endforeach; ?>
      </br></br></div></div>
    <?php endforeach; ?>
      <div class="inline">
        <input type="hidden" name="tid" value="<?php echo $fbsession['status']; ?>">
        <input type="hidden" name="session" value="<?php echo $fbsession['id']; ?>">
        <input type="submit" class="btn btn-primary pull-right" value="Next" name="submit"></div>
  </form></div>
  <div class="well well-sm custom-well-small">
  <fieldset>
  <?php  if($fbsession['status']==6){
    echo "Thanks for providing feedback to us. Our team in Kombodia is checking this, Please click next to validate your feedback";
   echo "Alternatively you can invite your employer and parent to give feedback, Please enter their emails ids in below boxes";
   ?>
<form id="invite" action="" method="get" name="invite">
<input type="text" name="eemail" class="fa fa-email" placeholder="employer"/>
<input type="text" name="pemail" class="fa fa-email" placeholder="parent"/>
<input type="submit" class="btn btn-default" name="invite" value="invite" />
</form></fieldset>
   <?php
  }
?>
</div>

  <br>
  <br>
<script>
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
    var url = '../api/alumniFB.php';
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
        window.location.replace("");//reload page to get new form
      }
      }
    });
    // Prevent form from submitting twice
    e.preventDefault();
    });

        $("form[name='invite']").submit(function(e){
        var form = $(this);
        var url = '../api/inviteFB.php';
        var serializedData = form.serialize();
        serializedData += '&ajaxMode=true';
        $.ajax({
          type: "GET",
          url: url,
          data: serializedData,
          success: function(result) {
          var resultJSON = processJSONResult(result);
          if (resultJSON['errors'] && resultJSON['errors'] > 0){
            alertWidget('display-alerts');
            alert(" Fill details or enter correct details");
          } else {
            alert("invite has been sent. Closing feedback");//reload page to get new form
            $("form[name='al1']").find('input[type="submit"]').trigger('click');
            }
          }
        });
        // Prevent form from submitting twice
        e.preventDefault();
        });
  });
</script>
</body>
</html>
