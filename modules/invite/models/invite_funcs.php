<?php
/*

UserFrosting Version: 0.2.1 (beta)
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
  
        $query ="UPDATE uf_invites SET status=".$status.", accepted=123 WHERE (inviteToken='".$token."')" ;  
	
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

