<?php require "base.php" ?>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<body>
<div id="main">
<?php
$_POST = strip_sym($_POST);
if(!empty($_POST['username']) && !empty($_POST['password'])){
    $username = $_POST['username'];
    $password = $_POST['password'];

    $chk_u_name = oci_parse($conn, "SELECT * FROM users WHERE u_name = '".$username."'");
    oci_execute($chk_u_name);
    while ($row = oci_fetch_array($chk_u_name, OCI_ASSOC+OCI_RETURN_NULLS)){
      foreach ($row as $item){}}

    if( oci_num_rows($chk_u_name) == 1 ){
      echo "<h1>Sorry, bro, we've already got a muscly user with that name</h1>";
      echo "Go back and try again";
    }else{
      $f_name = $_POST['f_name'];
      $l_name = $_POST['l_name'];
      $email = $_POST['email'];
      $age = $_POST['age'];
      $qote = $_POST['quote'];
      $q_str = "INSERT INTO users(fname, lname, u_name, p_word, age, email, quote) VALUES('".$f_name."', '".$l_name."', '".$username."', '".$password."', '".$age."', '".$email."', '".$quote."')";
      $reg_query = oci_parse($conn, $q_str);
      $success = oci_execute($reg_query);
      oci_close($conn);

      if( $success ){
        echo "<h1>Good news, bro, you're in!</h1>";
        echo "<p>Now go <a href='index.php'>Log In</a> and get your swole on ... with books.</p>";
      }else{
        echo "<h1>Bro, you fucked up the database.  The power is you biceps is most impressive.</h1>";
        echo "<p>Try to <a href='register.php'>sign-up again</a>, but be gentler this time.</p>";
      }
    }
  }else{
?>  <h1>Register Your Guns</h1>
  <p>Tell us about yourself, and we'll tell you if you're bulgy enough to use our databse<br>
     Use only letters and numbers, all special characters will be removed like this guy:</p>
    <img src="images/arnold.gif" alt='Arnold tossing some fool' style='width:337px;height:200px'>
    <form method='post' action='register.php' name='registerform' id='refisterform'>
    <fieldset>
      <label for='username'>Username:</label><input type='text' name='username' id='username'><br>
      <label for='password'>Password:</label><input type='password' name='password' id='password'><br>
      <label for='email'>Email Addy:</label><input type='text' name='email' id='email'><br>
      <label for='f_name'>First Name:</label><input type='text' name='f_name' id='f_name'><br>
      <label for='l_name'>Last Name:</label><input type='text' name='l_name' id='l_name'><br>
      <label for='age'>Age:</label><input type='text' name='age' id='age'><br>
      <label for='quote'>Quote:</label><input type='text' name='quote' id='quote'><br>
      <input type='submit' name='register' id='register' value='Register'>
    </fieldset>
    </form>
<?php
  }
?>
  </div>
</body>
</html>
