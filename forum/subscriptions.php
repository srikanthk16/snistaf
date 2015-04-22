<?php
/*
SNISTAF Public Code
By Srikanth Kasukurthi
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
if(!isUserLoggedIn()) {
	addAlert("warning", "Login to continue!");
	apiReturnError($ajax, SITE_ROOT."login.php");
}
setReferralPage(getAbsoluteDocumentPath(__FILE__));
 ?>
<html>
<?php
//echo renderTemplate("head.html", array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Subscriptions"))	;
echo renderAccountPageHeader(array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Subscriptions"));
?>


<body>
	<div id="wrapper">
		<?php echo renderMenu("Forum");
		?>

	<div id="pagewrapper" padding-left="60px" >
		<ol class="breadcrumb">
		<li><a href="#">Forums</a></li>
		</ol>
		<div class="row">
				<div id='display-alerts' class="col-lg-12">

				</div>
			</div>
	<?php
	$user_id=$loggedInUser->user_id;
	$resultarray = loadSubscriptions($user_id);
	if(empty($resultarray)){
		echo "Goku is gathering energy for you";
		autoSubscribe($user_id);
		header("");//very bad usage. please use ajax in further development
	}
	if(isset($_GET['page'])){
	$offset=$_GET['page'];}
	else
	$offset=0;
	$arr_length=count($resultarray);
	//print_r($arr_length);
	$results=array_slice($resultarray,$offset*10,($offset*10)+10,true);

	//print_r($resultarray);
	 ?>
	<!--<script>
	      $(document).ready(function() {

	    // Load jumbotron links
	    $(".jumbotron-links").load("jumbotron_links.php");

	    alertWidget('display-alerts');
	    var form = $(this);
	    var url = '../api/loadSubscriptions.php';
	    $.ajax({
	      type: "GET",
	      url: url,
	      data: {
	      userid:	0,
	      ajaxMode:	"true"
	      },
	      success: function(result) {
	      var resultJSON = processJSONResult(result);
	      if (resultJSON['errors'] && resultJSON['errors'] > 0){
	        alertWidget('display-alerts');
	      } else {
	        var str=JSON.stringify(resultJSON,' ');
	        /*window.location.replace("");
	        alertWidget('success');*/
	        alert(str);
	        //window.location.replace("subscriptions.php");
	      }
	      }
	    });

	  });
	</script>-->


<table class="table ">
	<thead>
		<th class="col-md-6">Your Subscribed Forums</th>
		<th class="col-md-1">Posts</th>
	</thead>
	<tbody>
<?php foreach ($results as $row): array_map('htmlentities', $row); ?>
    <tr>
      <td class="col-md-6"><a href="viewForum.php?id=<?php echo intval($row[0]);?>" ><?php echo $row[1]; ?></a></td>
			<td class="cold-md-1"><?php echo $row[2];?></td>
    </tr>
<?php endforeach; ?>
  <tbody>
</table>
<ul class="pager">
<li><a href="?page=<?php echo $offset==0?0:$offset-=1;?>" ><span  aria-hidden="true" class="fa fa-angle-left" ></span></a>
</li><li ><a href="?page=<?php echo $offset*10<$arr_length?$offset:$offset+=1;?>" ><span aria-hidden="true" class="fa fa-angle-right"></span></a>
</li></ul>
	</div>

	</div>
	<script>
        $(document).ready(function() {
          alertWidget('display-alerts');
		});
	</script>

  <?php echo renderTemplate("footer.html"); ?>
</body>
</html>
