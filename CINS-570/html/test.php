<!DOCTYPE>
<html>
<head></head>
<body>
<?php
  $symbols = array("/","\\",",",".",",","-","\#","_","!","*","(",")","[","]","{","}","|","<",">");
  if( $_POST){
    echo "<hr>";
    foreach( $_POST as $key => $value){
      echo $key." => ".$value."<br>";
      $value = str_replace($symbols, "", $value);
      echo "=============<br>";
      echo $value."<br>";
      echo "=============<br>";
      $_POST[$key] = $value;
    }
    echo "<hr>";
    var_dump($_POST);
  }
?>

<h1>TEST PAGE</h1>
<form action='test.php' method="post">
<input type='text' name='one'></br>
<input type='text' name='two'></br>
<input type='text' name='three'></br>
<input type='submit' name='submit' value='test'><br>
</form>




</body>
</html>
