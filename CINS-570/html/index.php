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
<div id="main">
 <?php
  if(!empty($_SESSION['LoggedIn']) && !empty($_SESSION['Username'])){
    // access page
    oci_close($conn);
    render_mmbr_header();
?>

    <p> Hello, <?php echo $_SESSION['Username']?>.Your biceps are in good company. </p>
    <p>What do you want to do?</p>
    <table style="width:100%;" align="center" border=1>
    <tr>
      <td><a href=collections.php>Manage Your Collections</a></td><td>Manage Shared Collections</td>
    </tr><tr>
      <td>View All: <a href='view.php?item=books'>Books</a>
                    <a href='view.php?item=cds'>CDs</a> Or 
                    <a href='view.php?item=movies'>Movies</a>          
      <td>Add A: <a href='add.php?item=book'>Book</a>
                 <a href='add.php?item=cd'>CD</a> Or
                 <a href='add.php?item=movie'>Movie</a></td>
    </tr><tr>
      <td colspan=2><a href="find.php">
                      Find Items And Purge Them From The Database IF They Are Weak</a></td>
    </tr><tr>
      <td colspan=2>
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" > 
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" > 
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" > 
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <img src="images/bicep_small_l.png" style="width:10px;height:15px" >
        <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ">Party With Rockstars!</a>
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" >
        <img src="images/bicep_small.png" style="width:10px;height:15px" ></td>
    </tr>
    </table>
  
<?php

  }elseif(!empty($_POST['username']) && !empty($_POST['password'])){
    // log in sequence

    $username = $_POST['username'];
    $password = $_POST['password'];
    $sql_q = "SELECT * FROM users WHERE u_name = '".$username."' AND p_word = '".$password."'";
    $chklogin = oci_parse($conn, $sql_q);
    oci_execute($chklogin);
    oci_close($conn);

    
    while ($row = oci_fetch_array($chklogin, OCI_ASSOC+OCI_RETURN_NULLS)) {
      $_SESSION['id'] = $row['ID'];
      $_SESSION['email'] = $row['EMAIL'];
      $_SESSION['Username'] = $_POST['username'];
      $_SESSION['LoggedIn'] = 1;
    }
    if( oci_num_rows($chklogin) == 1 ){
      echo "<h1>Success</h1>";
      echo "<p>You've been logged in and are being redirected to the member area.</p>";
      echo "<meta http-equiv='refresh' content='2;index.php' />";
    }else{
      echo "<h1>Are you trying to hack me, bro?!<br> Try that shit again and I'll call the 
            <a href='http://internetpolice.us'> Internet Police</a>.</h1>";
      echo "<h4>If you aren't a hacker, click <a href='index.php'>here</a> to try again.</h4>";
    }
  }else{
    //display the login form
    oci_close($conn);
    ?>
    <h1>Member Login</h1>
    <p>You've arrived at the biggest, baddest, most muscular database on the net! Ever!<br>
       Just ask the doge, he knows. Now log in or sign up to feel some of the db bicep goodness!</p>
    <p><a href='register.php'>Register your guns ... for the gun show!</a>
    <form method='post' action='index.php' name='loginform' id='loginform'>
    <fieldset>
      <label for='username'>Username:</label><input type='text' name='username' id='username' /><br>
      <label for="password">Password:</label><input type="password" name="password" id="password" /><br>
      <input type="submit" name="login" id="login" value="Login">
    </fieldset>
    </form>
  <?php
  }  
?>
</div>
</body>
</html>
