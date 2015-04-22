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
  ?>
  <?php
  $userid=$_GET['id'];
  /* write some algoirthm to validate parent/employere here*/
  ?>
  <body>

 <div class="well well-sm custom-well-small">

   <form class="form-inline" action="../api/addParentFB.php" method="get" name="pa">
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



    <input type="hidden" name="uid" value="<?php echo $userid;?>">






]
           <legend>III)About the College</legend>
           <table class="center">
           <tr>
           <td>
           <span>a)Infrastructure of the College		  </span>
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
           <span>b)Faculty		 </span>
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
           <span>c)Curricular aspects of the college	</span>
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
           <span>d)Placement	</span>
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
           <span>e)Discipline of the College		</span>
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
           <span>f)Library		</span>
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
           <span>g)Cocurricular and extra curricular activities (Sports/Games/NSS/Cultural)		</span>
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
           <span>h)Development of Employability skills (Campus recruitment training facilities)		</span>
           </td>
           <td>
           <input type="text" name="h">
           </td>
           </tr>







           </table>
           <input type="submit" class="btn btn-primary pull-right" value="Thank you">
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

 		  $("form[name='pa']").submit(function(e){
 			var form = $(this);
 			var url = '../api/parentFB.php';
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
</body>
</html>
