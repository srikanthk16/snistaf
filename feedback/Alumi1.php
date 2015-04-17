<?php
/*

UserFrosting Version: 0.2.2
By Alex Weissman
Copyright (c) 2014

Based on the UserCake user management system, v2.0.2.
Copyright (c) 2009-2012

UserFrosting, like UserCake, is 100% free and open-source.

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
global $email_login;

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
?>
<div><b><div id="heading">Rank-Guidance for feedback:<b></div> <i> Please give your opinion as  stated  below for all the items given here under .</i> </div>
<table width="800px">
<tr>
<th>
Very Good :5
</th>
<th>
Good :4
</th>
<th>
 Average :3
</th>
<th>
Satisfactory :2
</th>
<th>
Not So Satisfactory  :1
</th>
</tr>
</table>
<br>



<?php
if($step==1){
?>
<form name="al1" method="get" action="../api/alumniFB1.php">
<table width="800px">
<tr>
<th>
  Attainment  of  B.Tech C.S.E Programme Educational Objectives
</th>
<th>
  Rank
</th>
</tr>
<tr>
<td>
 PEO �A: Graduates of the program will have requisite engineering knowledge with abilities for analysis of the problem and

to design, development of solutions and to arrive at an optimal solution using modern tools which help them to be

employable.
<input type="hidden" name="uid" value="<?php echo $userid;?>">
</td>
<td>
<input type="text" class="inputwidth" name="a"></input>
</td>
</tr>
<tr>
<td>
  PEO � B : Ability to work in a team/ lead a team which needs effective communication skills and knowledge of project

management, finance and entrepreneurial abilities.
</td>
<td>
<input type="text" class="inputwidth" name="b"></input>
</td>
</tr>
<tr>
<td>
   PEO- C : Graduates should have abilities to conduct investigation of complex problems and attitude for lifelong learning

skills which will enable them to pursue advanced studies, Research and Development.
</td>
<td>
<input type="text" class="inputwidth" name="c"></input>
</td>
</tr>
<tr>
<td>
 PEO-D  : The graduates must be aware of the engineering professional ethics, the impact of engineering profession on the

society and the need for environmental protection and sustainable development
</td>
<td>
<input type="text" class="inputwidth" name="d"></input>
</td>
</tr>
</table>
<input type="submit" value="submit">
</form>
<script>
        $(document).ready(function() {
		  // Load navigation bar

		  // Load jumbotron links
		  $(".jumbotron-links").load("jumbotron_links.php");
		  alertWidget('display-alerts');

		  $("form[name='al1']").submit(function(e){
			var form = $(this);
			var url = '../api/alumniFB1.php';
			$.ajax({
			  type: "GET",
			  url: url,
			  data: {
				uid: form.find('input[name="uid"]').val(),
				a:	form.find('input[name="a"]').val(),
				b:	form.find('input[name="b"]').val(),
				c:	form.find('input[name="c"]').val(),
				d:	form.find('input[name="d"]').val(),
				ajaxMode:	"true"
			  },
			  success: function(result) {
				var resultJSON = processJSONResult(result);
				if (resultJSON['errors'] && resultJSON['errors'] > 0){
				  alertWidget('display-alerts');

				} else {
				  window.location.replace("?step=2");
				}
			  }
			});
			// Prevent form from submitting twice
			e.preventDefault();
		  });

		});
	</script>
<?php }
elseif($step==2){
?>
<form method="get" name="al4" action="../api/alumniFB4.php">
<table width="800px">
<tr>
<th colspan="2">Employability</th>
</tr>
<tr>
<td>
	<input type="hidden" value="<?php echo $loggedInUser->user_id;?>">
1)Pl. rate provision of employability enhancement activity through curriculum itself [ LR, QA, Soft skills]
</td>
<td> <input type="text" class="inputwidth" name="a"></td>
</tr>
<tr>
<td>
2)Rate provision of employability enhancement activity through external experts [ CRT etc.]
</td>
<td> <input type="text" class="inputwidth" name="b"></td>
</tr>
<tr>
<td>
3)Rate the study/practice  material given to you for employability  enhancement
</td>
<td> <input type="text" class="inputwidth" name="c"></td>
</tr>
<tr>
<td>
4)Rate  the  Career Guidance  received through faculty and External Trainers
</td>
<td> <input type="text" name="d" class="inputwidth"></td>
</tr>
<tr>
<td>
5)Rate the Placement services ,  Placement intimation / off campus placement etc.
</td>
<td> <input type="text" class="inputwidth" name="e"></td>
</tr>


</table>
<input type="submit" value="submit" >
</form>
<script>
        $(document).ready(function() {
		  // Load navigation bar

		  // Load jumbotron links
		  $(".jumbotron-links").load("jumbotron_links.php");
		  alertWidget('display-alerts');

		  $("form[name='al4']").submit(function(e){
			var form = $(this);
			var url = '../api/alumniFB4.php';
			$.ajax({
			  type: "GET",
			  url: url,
			  data: {
				uid: form.find('input[name="uid"]').val(),
				a:	form.find('input[name="a"]').val(),
				b:	form.find('input[name="b"]').val(),
				c:	form.find('input[name="c"]').val(),
				d:	form.find('input[name="d"]').val(),
				e: 	form.find('input[name="e"]').val(),
				ajaxMode:	"true"
			  },
			  success: function(result) {
				var resultJSON = processJSONResult(result);
				if (resultJSON['errors'] && resultJSON['errors'] > 0){
				  alertWidget('display-alerts');

				} else {
				  window.location.replace("?step=3");
				}
			  }
			});
			// Prevent form from submitting twice
			e.preventDefault();
		  });

		});
	</script>
<?php }
elseif($step==3){
?>

<?php }
elseif($step==4){
?>

<?php }
else{
?>


<?php }?>

</body>
</html>
