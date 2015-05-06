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

//place some algoirthm to check feedback is done/given by correct person or not


?>
<!DOCTYPE html>
<html lang="en">
  <?php
	echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Feedback"));
  ?><body>
  <?php
  $userid=$_GET['id'];
  $step=$_GET['step'];
  /* write some algoirthm to validate parent/employere here*/
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

  	    <form class="form-inline" name="em1" method="get" action="../api/empFB1.php">
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

  		  $("form[name='em1']").submit(function(e){
  			var form = $(this);
  			var url = '../api/empFB1.php';
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
  				  window.location.replace("?step=2&id=<?php echo $userid;?>");
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

      <form class="form-inline" name="em2" method="get" action="../api/empFB2.php">
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

  		  $("form[name='em2']").submit(function(e){
  			var form = $(this);
  			var url = '../api/empFB2.php';
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
  				  window.location.replace("?step=3&id=<?php echo $userid;?>");
  				}
  			  }
  			});
  			// Prevent form from submitting twice
  			e.preventDefault();
  		  });

  		});
  	</script>
    <?php }
    else { ?>

      <div class="well well-sm custom-well-small">

          <form class="form-inline" method="get" action="../api/empFB3.php" name="em3">
              <fieldset>
                  <legend> Attainment level of Professional Skills of Students  </legend>
                  <table class="center">
                  <tr>
                  <td>
                  <span> 1)Pl. rate the ability to use technology such as Information Technology tools and other office technology. </span>
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
                  <span> 2)Pl. rate the ability to complete tasks accurately with few errors; making sure established standards and processes are met. </span>
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
                  <span> 3)Pl. rate the ability to utilize the time in a productive way and Prioritize responsibilities effectively  </span>
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
                  <span> 4)Rate the oral and written communication skills  </span>
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
                  <span> 5)Rate the ability to evaluate a situation objectively and decide upon an appropriate course of action or solution to a problem  </span>
                  </td>
                  <td>
                  <input type="text">
                  </td>
                  </tr>


                  </tr>
                    <tr>
                     <td colspan="2" name="e">
                     <hr>
                     </td>
                     </tr>

                   <tr>
                  <td>
                  <span> 6)Rate the extent of ownership of the job and accepts the related responsibilities in their entirety. Takes responsibility for the both the successes and mistakes that are realized </span>
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
                  <span> 7)Rate his/her privacy of others and follows offices guidelines for confidentiality  </span>
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
                  <span> 8)Rate his/her ability to be proactive or asks supervisor for new tasks after all assigned work is completed.  </span>
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
                  <span> 9)Rate his/her cooperation with other team members in tasks, sharing responsibilities, and working towards common goals. </span>
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
                  <span> 10)Rate his/her ability to get along with others and sensitivity to different ethnic, cultural, age, gender, education. Willingness to ask supervisor for clarification when unsure of responsibilities </span>
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
                  <span> 11)Rate his/her attitude on being punctual.  </span>
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
                  <span> 12)Rate his/her ability to accept new assignments/respond well to changes in policy or process, integrates easily with new people, readily agrees to revision in schedule. </span>
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
                  <span> 13)Rate his/her ability to collaborate and engage in multidisciplinary tasks  </span>
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
                  <span> 14) Rate his/her ability to acquire professional ethics and intellectual integrity and good conduct   </span>
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
                  <span> 15)Rate his/her compliance to organizational policies regarding professional office decorum i.e. dress code, visitor policy. </span>
                  </td>
                  <td>
                  <input type="text" name="o">
                  </td>
                  </tr>




                              </table>
      <input type="hidden" name="uid" value="<?php echo $userid; ?>">
      <input type="submit" class="btn btn-primary pull-right" value="Thank You">
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

      		  $("form[name='em3']").submit(function(e){
      			var form = $(this);
      			var url = '../api/empFB3.php';
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
