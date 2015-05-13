<?php
/*
Srikanth Kasukurthi for SNISTAF
copyright(c) 2015
*/

function invitesLeft($userid)
{
 	global $loggedInUser, $db_table_prefix;
	if($loggedInUser == NULL){
		return false;//if $loggedInUser is null, we don't need to check the database. KISS
	}else{
        try {
            $db = pdoConnect();
            $sqlVars = array();
        	$query ="SELECT * FROM uf_user_invites WHERE userId = ".$userid;

            $stmt = $db->prepare($query);

            if (!$stmt->execute($sqlVars)){
                // Error: row does not exist
                return false;
            }

            $row = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($row)
                return $row['invitesLeft'];
            else {
                return -1;//no invites
            }
        } catch (PDOException $e) {
          addAlert("danger", "Oops, looks like our database encountered an error.");
          error_log("Error in " . $e->getFile() . " on line " . $e->getLine() . ": " . $e->getMessage());
          return false;
        } catch (ErrorException $e) {
          addAlert("danger", "Oops, looks like our server might have goofed.  If you're an admin, please check the PHP error logs.");
          return false;
        } catch (RuntimeException $e) {
          addAlert("danger", "Oops, looks like our server might have goofed.  If you're an admin, please check the PHP error logs.");
          error_log("Error in " . $e->getFile() . " on line " . $e->getLine() . ": " . $e->getMessage());
          return false;
        }
    }

}

function createInvite($user_id,$email,$message,$token)
{
  	global $loggedInUser, $db_table_prefix;
	if($loggedInUser == NULL){
		return false;//if $loggedInUser is null, we don't need to check the database. KISS
	}else{
        try {

           $db = pdoConnect();
            $sqlVars = array();
        	$query ="INSERT INTO uf_invites (inviterId,invitedEmail,message,inviteToken,status) values (".$user_id.",'".$email."','".$message."','".$token."',0)" ;
//        	$query ="INSERT INTO uf_invites (inviterId,invitedEmail,message,status) values (".$user_id.",'".$email."','".$message."',0)" ;
            $stmt = $db->prepare($query);
            $stmt->execute($sqlVars);

        } catch (PDOException $e) {
          addAlert("danger", "Oops, looks like our database encountered an error.");
          error_log("Error in " . $e->getFile() . " on line " . $e->getLine() . ": " . $e->getMessage());
          return false;
        } catch (ErrorException $e) {
          addAlert("danger", "Oops, looks like our server might have goofed.  If you're an admin, please check the PHP error logs.");
          return false;
        } catch (RuntimeException $e) {
          addAlert("danger", "Oops, looks like our server might have goofed.  If you're an admin, please check the PHP error logs.");
          error_log("Error in " . $e->getFile() . " on line " . $e->getLine() . ": " . $e->getMessage());
          return false;
        }
    }
}


function validateToken($token)
{
	global $db_table_prefix;
    try {
        $db = pdoConnect();
        $sqlVars = array();
        $query ="SELECT * FROM uf_invites  WHERE (inviteToken='".$token."') and (status=0)" ;

        $stmt = $db->prepare($query);
        $stmt->execute($sqlVars);
        if ($stmt->rowCount() < 1) {
 	//		addAlert("danger", "This invitation is invalid or allready used. (validate)");
 		//	echo "not found";
 			return 0;
  			// don't show form
		}
		else
		{
		//	echo "found";
			return 1;
        }
    } catch (PDOException $e) {
          addAlert("danger", "Oops, looks like our database encountered an error.");
          error_log("Error in " . $e->getFile() . " on line " . $e->getLine() . ": " . $e->getMessage());
          return false;
    } catch (ErrorException $e) {
          addAlert("danger", "Oops, looks like our server might have goofed.  If you're an admin, please check the PHP error logs.");
          return false;
    } catch (RuntimeException $e) {
          addAlert("danger", "Oops, looks like our server might have goofed.  If you're an admin, please check the PHP error logs.");
          error_log("Error in " . $e->getFile() . " on line " . $e->getLine() . ": " . $e->getMessage());
          return false;
    }
}

function confirmInviteRegistration($token,$status)
{
global $db_table_prefix;
    try {
        $db = pdoConnect();
        $sqlVars = array();

        $query ="UPDATE uf_invites SET status=".$status.", accepted=NOW() WHERE (inviteToken='".$token."')" ;

        $stmt = $db->prepare($query);
        $stmt->execute($sqlVars);
        if ($stmt->rowCount() < 1) {
 			// addAlert("danger", "This invitation is invalid or allready used.");
 			return 0;
  			// don't show form
		}
		else
		{
			return 1;
        }
    } catch (PDOException $e) {
          addAlert("danger", "Oops, looks like our database encountered an error 23.");
          error_log("Error in " . $e->getFile() . " on line " . $e->getLine() . ": " . $e->getMessage());
          return false;
    } catch (ErrorException $e) {
          addAlert("danger", "Oops, looks like our server might have goofed.  If you're an admin, please check the PHP error logs.");
          return false;
    } catch (RuntimeException $e) {
          addAlert("danger", "Oops, looks like our server might have goofed.  If you're an admin, please check the PHP error logs.");
          error_log("Error in " . $e->getFile() . " on line " . $e->getLine() . ": " . $e->getMessage());
          return false;
    }
}


?>
