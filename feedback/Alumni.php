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
if($step==1){
?>

	<div class="well well-sm custom-well-small">

	    <form class="form-inline" name="al1" method="get" action="../api/alumniFB1.php">
	        <fieldset>
	            <legend>Alumini Feed Back Form</legend>
	            <table class="center">
	            <tr>
	            <td>
	            <span>PEOA: Graduates of the program will have requisite engineering knowledge with abilities for analysis of the problem and to design, development of solutions and to arrive at an optimal solution using modern tools which help them to be employable.  </span>
	            <td>
	            <input type="text" name="a">
	            </td>

	            </tr>
	              <tr>
	               <td colspan="2">
	               <hr>
	               </td>
	               </tr>


	             <tr>
	            <td>
	            <span>PEOB: Ability to work in a team/ lead a team which needs effective communication skills and knowledge of project management, finance and entrepreneurial abilities. </span>
	            </td>
	            <td>
	            <input type="text" name="b">
	            </td>
	            </tr>

	              </tr>
	              <tr>
	               <td colspan="2">
	               <hr>
	               </td>
	               </tr>

	             <tr>
	            <td>
	            <span>PEO-C: Graduates should have abilities to conduct investigation of complex problems and attitude for lifelong learning skills which will enable them to pursue advanced studies, Research and Development.</span>
	            </td>
	            <td>
	            <input type="text" name="c">
	            </td>
	            </tr>

	              </tr>
	              <tr>
	               <td colspan="2">
	               <hr>
	               </td>
	               </tr>

	             <tr>
	            <td>
	            <span>PEO-D: The graduates must be aware of the engineering professional ethics, the impact of engineering profession on the society and the need for environmental protection and sustainable development </span>
	            </td>
	            <td>
	            <input type="text" name="d">
	            </td>
	          </tr>      </table>
						<input type="hidden" value="<?php echo $userid;?>" name="uid">
						<input type="submit" class="btn btn-primary pull-right" value="Next" name="submit">
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
			var url = '../api/alumniFB1.php';
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
<div class="well well-sm custom-well-small">

    <form class="form-inline" name="al2" method="get" action="../api/alumniFB2.php">
			<input type="hidden" value="<?php echo $userid; ?>" name="uid">
        <fieldset>
            <legend>Attainment of B.Tech C.S.E Program Outcomes </legend>
            <table class="center">
            <tr>
            <td>
            <span> a. An ability to apply knowledge of basic sciences, mathematics and engineering in the area of Computer Science. </span>
            <td>
            <input type="text" name="a">
            </td>

            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>


             <tr>
            <td>
            <span>b. An ability to design, implement and evaluate a software or software / hardware system to meet the desired needs within realistic constraints such as space and time. </span>
            </td>
            <td>
            <input type="text" name="b">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span>c. An ability to use the techniques, skills, and modern engineering tools such as software testing tools, data warehousing and mining tools, necessary for practice as a CSE professional. </span>
            </td>
            <td>
            <input type="text" name="c">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> d. An ability to analyze and solve open-ended problems using mathematical foundations, algorithmic principles, and computer science theory in the modeling and design of computer-based systems in a way that demonstrates comprehension of the tradeoffs involved in design choices and to arrive at an optimal solution  </span>
            </td>
            <td>
            <input type="text" name="d">
            </td>
            </tr>

            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span>  e. To understand principles of engineering, entrepreneurship with emphasis on women, and financial management through relevant management courses to demonstrate knowledge in the conceptualization and realizing group projects, mini & main projects.  </span>
            </td>
            <td>
            <input type="text" name="e">
            </td>
            </tr>


            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> f. An ability to function effectively as individual and as a member or leader in diverse team in achieving multidisciplinary tasks.   </span>
            </td>
            <td>
            <input type="text" name="f">
            </td>
            </tr>


            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> g. Learn to communicate effectively on complex engineering activities through report writing, experimental work, assignments, seminars, group projects, mini & main projects.  </span>
            </td>
            <td>
            <input type="text" name="g">
            </td>
            </tr>


            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> h. To recognize the need for and have the preparation and ability to be a life-long learner through the courses such as seminars & projects.  </span>
            </td>
            <td>
            <input type="text" name="h">
            </td>
            </tr>


            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span>i. An ability to identify, formulate and analyze engineering problems.  </span>
            </td>
            <td>
            <input type="text" name="i">
            </td>
            </tr>


            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span>j. An ability to conduct investigation of complex problems in multidisciplinary areas.  </span>
            </td>
            <td>
            <input type="text" name="j">
            </td>
            </tr>


            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> k. An understanding of professional ethics and responsibilities.   </span>
            </td>
            <td>
            <input type="text" name="k">
            </td>
            </tr>


            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> l. An engineer should be aware of social, safety, cultural and information security issues and also responsibilities relevant to professional practice and skills.  </span>
            </td>
            <td>
            <input type="text" name="l">
            </td>
            </tr>


            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> m. An ability to understand the impact of environmental protection and sustainable development   </span>
            </td>
            <td>
            <input type="text" name="m">
            </td>
            </tr>




                        </table>
<input class="btn btn-primary pull-right" type="submit" value="Next" name="submit">
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

		  $("form[name='al2']").submit(function(e){
			var form = $(this);
			var url = '../api/alumniFB2.php';
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
<div class="well well-sm custom-well-small">

	<form class="form-inline" name="al3" method="get" action="../api/alumniFB3.php">
			<fieldset>
					<legend>Curriculum</legend>
					<table class="center">








					<tr>
					<td>
					<span>1)Rate the syllabus of the programme with regard to proper distribution of the subjects in the areas of basic sciences including mathematics, humanities and management courses, interdisciplinary courses, departmental core courses, electives and projects  </span>
					</td>
					<td>
					<input type="text" name="a">
					</td>
					</tr>


					</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 2)Rate your opinion on % of credits given in your curriculum for Basic Sciences including Mathematics - Presently about 15%. If you think this proportion is OK pl. Rank as 5 or else [4/3/2/1]  </span>
					</td>
					<td>
					<input type="text" name="b">
					</td>
					</tr>

					</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 3)Rate your opinion on % of credits given in your curriculum for Humanities and Management courses - Presently about 10%. If you think this proportion is OK pl. Rank as 5 or else [4/3/2/1] </span>
					</td>
					<td>
					<input type="text" name="c">
					</td>
					</tr>


					</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 4)Rate your opinion on % of credits given in your curriculum for Professional Core - Presently about 50%. If you think this proportion is OK pl. Rank as 5 or else [4/3/2/1]. </span>
					</td>
					<td>
					<input type="text" name="d">
					</td>
					</tr>


					</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 5)Rate your opinion on % of credits given in your curriculum for Electives - Presently about 15%. If you think this proportion is OK pl. Rank as 5 or else [4/3/2/1] </span>
					</td>
					<td>
					<input type="text" name="e">
					</td>
					</tr>


					</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 6)Rate your opinion on % of credits given in your curriculum for Other inter disciplinary Courses - Presently about 10%. If you think this proportion is OK pl. Rank as 5 or else [4/3/2/1]  </span>
					</td>
					<td>
					<input type="text" name="f">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 7)Rate the extent of usefulness with regard to Basic Sciences including Mathematics .   </span>
					</td>
					<td>
					<input type="text" name="g">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 8)Rate the extent of usefulness with regard to Humanities and Management courses.  </span>
					</td>
					<td>
					<input type="text" name="h">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 9)Rate the extent of usefulness with regard to Professional Core .  </span>
					</td>
					<td>
					<input type="text" name="i">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 10)Rate the extent of usefulness with regard to Electives.  </span>
					</td>
					<td>
					<input type="text" name="j">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 11)Rate the extent of usefulness with regard to inter disciplinary Courses .  </span>
					</td>
					<td>
					<input type="text" name="k">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 12)Rate the syllabus content of Basic Sciences including Mathematics was easy or difficult.  </span>
					</td>
					<td>
					<input type="text" name="l">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 13)Rate the syllabus content of Humanities and Management courses was easy or difficult.  </span>
					</td>
					<td>
					<input type="text" name="m">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 14)Rate the syllabus content of Professional Core was easy or difficult. </span>
					</td>
					<td>
					<input type="text" name="n">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 15)Rate the syllabus content of Electives was easy or difficult.   </span>
					</td>
					<td>
					<input type="text" name="o">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 16)Rate the syllabus content of inter disciplinary Courses was easy or difficult.  </span>
					</td>
					<td>
					<input type="text" name="p">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 17)Rate the overall programme  </span>
					</td>
					<td>
					<input type="text" name="q">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 18)Rate the extent of Opportunities given to you to perform as team member / team leader.[group, mini , major project, co-curricular and extra-curricular activities such as ADASTRA, SREEVISION, ARTS CLUB, ROBOVEDA, SPARDHA etc..  </span>
					</td>
					<td>
					<input type="text" name="r">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 19)Rate the extent of conduct of Seminars, workshops and student development programmes has enabled you to improve oral, written communication and technical skills.  </span>
					</td>
					<td>
					<input type="text" name="s">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 20)Rate the extent of attainment of technical abilities through group, mini and main projects to face the challenges of taking up new projects in your professional career .  </span>
					</td>
					<td>
					<input type="text" name="t">
					</td>
					</tr>

						</tr>
						<tr>
						<td colspan="2">
						<hr>
						</td>
						</tr>

					<tr>
					<td>
					<span> 21)Rate the extent of utility of IT courses and software tools to design and develop the application were adequate in your professional advancement .  </span>
					</td>
					<td>
					<input type="text" name="u">
					</td>
					</tr>









					</table>

<input type="hidden" name="uid" value="<?php echo $userid;?>">

<input type="submit" class="btn btn-primary pull-right" value="next">







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

		  $("form[name='al3']").submit(function(e){
			var form = $(this);
			var url = '../api/alumniFB3.php';
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
				  window.location.replace("?step=4");
				}
			  }
			});
			// Prevent form from submitting twice
			e.preventDefault();
		  });

		});
	</script>
<?php }
elseif($step==4){
?>
<div class="well well-sm custom-well-small">

    <form class="form-inline" name="al4" method="get" action="../api/addAlumniFB4.php">
        <fieldset>
            <legend> Overall impression </legend>
            <table class="center">
            <tr>
            <td>
            <span> 1)Pl. rate the facilities provided in the class rooms [ LCDs , OHPs, Lighting etc..]   </span>
            <td>
            <input type="text" name="a">
            </td>

            </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>


             <tr>
            <td>
            <span> 2)Rate the functioning of the Laboratory equipment [Facility for conduct of experiment ]  </span>
            </td>
            <td>
            <input type="text" name="b">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> 3)Rate the services provided by the library[ book bank schemes etc] </span>
            </td>
            <td>
            <input type="text" name="c">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> 4)Rate the computing services at SNIST ?[Software facilities, Internet , WiFi , Xerox facility , Printing facility ] </span>
            </td>
            <td>
            <input type="text" name="d">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> 5)Pl. rate the encouragement given by the Executive Director / Principal and others in the Co-Curricular activities under the banner of IEEE, ISTE, IETE etc. </span>
            </td>
            <td>
            <input type="text" name="e">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> 6)Pl. rate the extent of facilities provided to you for sports and games at SNIST ?  </span>
            </td>
            <td>
            <input type="text" name="f">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> 7)Rate the encouragement given for Extra-Curricular activities for personality development activities under ARTS CLUB, SPARDA etc.  </span>
            </td>
            <td>
            <input type="text" name="g">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> 8)Rate encouragement given engaging in service given to society . [ Bachpan Bachao, Street Cause, NSS etc.]  </span>
            </td>
            <td>
            <input type="text" name="h">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> 9)Rate the quality of Hostel facilities available ?[pl. answer if you are using this] </span>
            </td>
            <td>
            <input type="text" name="i">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> 10)Rate the Canteen facilities available at SNIST. [pl. answer if you are using this]  </span>
            </td>
            <td>
            <input type="text" name="j">
            </td>
            </tr>

              </tr>
              <tr>
               <td colspan="2">
               <hr>
               </td>
               </tr>

             <tr>
            <td>
            <span> 11)Rate the administration services provided by the college. [Physical Education , Transport , Accounts etc.]  </span>
            </td>
            <td>
            <input type="text" name="k">
            </td>
            </tr>







            </table>

						            <input type="hidden" name="uid" value="<?php echo $userid; ?>">
						<input type="submit" class="btn btn-primary pull-right" value="next">
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

		  $("form[name='al4']").submit(function(e){
			var form = $(this);
			var url = '../api/alumniFB4.php';
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
				  window.location.replace("?step=5");
				}
			  }
			});
			// Prevent form from submitting twice
			e.preventDefault();
		  });

		});
	</script>
	<?php }
	elseif($step==5){?>


	<div class="well well-sm custom-well-small">

	    <form class="form-inline" name="al5" method="get" action="../api/alumniFB5.php">
	        <fieldset>
	            <legend>Employability</legend>
	            <table class="center">
	            <tr>
	            <td>
								<span> 1)Pl. rate provision of employability enhancement activity through curriculum itself [ LR, QA, Soft skills] </span>
</td>	            <td>
	            <input type="text" name="a">
	            </td>

	            </tr>
	              <tr>
	               <td colspan="2">
	               <hr>
	               </td>
	               </tr>


	             <tr>
	            <td>
	            <span> 2)Rate provision of employability enhancement activity through external experts [ CRT etc.]  </span>
	            </td>
	            <td>
	            <input type="text" name="b">
	            </td>
	            </tr>

	              </tr>
	              <tr>
	               <td colspan="2">
	               <hr>
	               </td>
	               </tr>

	             <tr>
	            <td>
	            <span> 3)Rate the study/practice material given to you for employability enhancement.</span>
	            </td>
	            <td>
	            <input type="text" name="c">
	            </td>
	            </tr>

	              </tr>
	              <tr>
	               <td colspan="2">
	               <hr>
	               </td>
	               </tr>

	             <tr>
	            <td>
	            <span> 4)Rate the Career Guidance received through faculty and External Trainers </span>
	            </td>
	            <td>
	            <input type="text" name="d">
	            </td>
	            </tr>

	              </tr>
	              <tr>
	               <td colspan="2">
	               <hr>
	               </td>
	               </tr>

	             <tr>
	            <td>
	            <span> 5)Rate the Placement services , Placement intimation / off campus placement etc. </span>
	            </td>
	            <td>
	            <input type="text" name="e">
	            </td>
	            </tr>







	            </table>
	<input type="hidden" name="uid" value="<?php echo $userid; ?>">
	<input type="submit" class="btn btn-primary pull-right" value="next">
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

			  $("form[name='al5']").submit(function(e){
				var form = $(this);
				var url = '../api/alumniFB5.php';
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
					  window.location.replace("?step=6");
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
