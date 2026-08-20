<!DOCTYPE html>
<html>
<head>
  <?php   
    error_reporting(E_ALL);
    ini_set('display_errors', 1); 
    require "base.php"; 
  ?>  
  <link rel='icon' href='favicon.png'>
  <link rel='stylesheet' href='style.css' type='text/css' />
</head>
<body>
<div id=main>
<?php
  render_mmbr_header();
  if(!empty($_SESSION['LoggedIn']) && !empty($_SESSION['Username'])){
    
    $sql = "DELETE FROM ".$_GET['table']." WHERE ".$_GET['col']." = ".$_GET['term'];
    $stmt = oci_parse($conn, $sql);
    $success = oci_execute($stmt);
    if( !$success){
      oci_commit($conn);
      echo '<h1>Deletion Failed</h1>';
      $e = oci_error($objParse);  
      echo "Error Delete [".$e['message']."]";
    }else{
      oci_rollback($conn);
      echo '<h1>Item Deleted</h1>';
      echo '<a href="find.php">Find Another One</a><br>';
    }
  }else{
    echo '<h1>GTFO!!</h1>';
  } 



?>
</div>
</body>
</html>
