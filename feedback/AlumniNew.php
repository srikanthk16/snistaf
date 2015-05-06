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

//Forward the user to their default page if he/she is already logged in
if(!isUserLoggedIn()) {
	addAlert("warning", "You're not logged in!");
	header("Location: ../login.php");
	exit();
}

?>
<!DOCTYPE html>
<html lang="en">
  <?php
	echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Feedback"));
  ?>
<?php
//$formid=$_GET['id'];
$step=$_GET['step'];
$userid=$loggedInUser->user_id;
if(!isAlumni($userid)){
	addAlert("warning", "Wassup Bro(/SIS)");
	header("Location:../index.php");
}
if(isFeedbackDone($userid)){
	addAlert("warning", "You're great, since giving feedback once is itself pain");
	header("Location:../index.php");
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
<?php
if($step<6){
?>

	<div class="well well-sm custom-well-small">

	    <form class="form-inline" name="al1" method="get" action="../api/alumniFB.php">

	        <fieldset>
						<?php $resultArray=loadFeedbackQuestions($step);
						//print_r($resultArray);
						 ?>
						<?php foreach ($resultArray as $row): array_map('htmlentities', $row); ?>
							<div class="inline">
							<span class="pull-left"><?php echo $row['question']; ?></span>
						<?php	$ansArr=loadFeedbackAnswers($row['id']);?>
							<?php foreach($ansArr as $val): array_map('htmlentities',$val);?>
								<label class="radio-inline center">
  <input type="radio" name="<?php echo $row['id']; ?>" id="inlineRadio" value="<?php echo $val['options']; ?>"> <?php echo $val['options']; ?>
</label>
							<?php endforeach; ?>

							</br></div>
						<?php endforeach; ?>
					</br></br>
					<div class="inline">
						<input type="hidden" name="tid" value="<?php echo $step; ?>">
						<input type="submit" class="btn btn-primary pull-right" value="Next" name="submit"></div>
	 </fieldset>
	    </form>
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
			var url = '../api/alumniFB.php';
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
				  window.location.replace("?step=<?php echo $step=$step+1;?>");
				}
			  }
			});
			// Prevent form from submitting twice
			e.preventDefault();
		  });

		});
	</script>
<?php }
else{
?>
<div class="well well-sm custom-well-small">

    <form class="form-inline" name="al6" method="get" action="../api/alumniFB6.php">
        <fieldset>
            <legend> Suggestions for Improvement </legend>
             <div class="form-group">
  <span><h4>Department Assessment</h4> <span> <br>
  <span>What are the 2 major strengths of your department?</span><br>
  <textarea class="form-control" rows="1" cols="30" name="a" id="comment"></textarea>
   <br>
  <span>What are the 2 major weaknesses of your department?</span><br>
  <textarea class="form-control" rows="1" cols="30" id="comment" name="b"></textarea>
    <br>
    <span> What are your suggestions for further improvement in the quality of your programme ? </span><br>
  <textarea class="form-control" rows="1" cols="30" id="comment" name="c"></textarea>
      <br>
      <span>  What are your suggestions for improvising the curriculum ? Any new courses should be offered / existing ones to be dropped ? [please specify] </span><br>
  <textarea class="form-control" rows="1" cols="30" id="comment" name="d"></textarea>



            </div>

						<input type="hidden" name="uid" value="<?php echo $userid; ?>">
						<input type="submit" class="btn btn-primary pull-right" value="Done">




 </fieldset>
    </form>
</div>
  <br>
  <br>
<script>
        $(document).ready(function() {
		  // Load navigation bar

		  // Load jumbotron links
		  $(".jumbotron-links").load("jumbotron_links.php");
		  alertWidget('display-alerts');

		  $("form[name='al6']").submit(function(e){
			var form = $(this);
			var url = '../api/alumniFB6.php';
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

				} else {
				  window.location.replace("../index.php");
				}
			  }
			});
			// Prevent form from submitting twice
			e.preventDefault();
		  });

		});
	</script>

<?php }?>

</body>
</html>
