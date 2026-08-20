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
<?php render_mmbr_header();
  echo '<div id="main">';
  if( !empty($_SESSION['LoggedIn']) && !empty($_SESSION['Username'])){
    if( $_GET['item'] == 'book'){
      echo '<h4>Add Book</h4>';
      var_dump($_POST);
      if( $_POST['submit'] == 'add_book'){
        if( $_POST['adult']? $adult = 0 : $adult = 1);
        $_POST = strip_sym($_POST);
        $sql = "INSERT INTO books(title, auth, isbn, adult) 
          VALUES('".$_POST['title']."', '".$_POST['auth']."', '"
                   .$_POST['isbn']."', ".$adult.")";
        var_dump($sql);
        $stmt = oci_parse($conn, $sql);
        $success = oci_execute($stmt);
        if( $success){
          echo '<h3>Your book was added to the database</h3>';
        }else{
          echo '<h3>That book was not beefy enough for this database.
                <br>Try again.</h3>';
        }
      }
?>

      <table id='form_table'>   
        <form action='add.php?item=book' method='POST' id='add_form'>
        <tr>
          <td>Title:</td> <td><input type='text' name='title'></td>
        </tr><tr>
          <td>Author:</td><td><input type='text' name='auth'></td>
        </tr><tr>
          <td>ISBN:</td><td><input type='text' name='isbn'></td>
        </tr><tr>
          <td>Kid Safe?</td><td><input type='checkbox' name='adult'></td>
        </tr><tr>
          <td></td><td><input type='submit' name='submit' value='add_book'></td></tr>
        </form>
      </table>
      <?php


    }elseif( $_GET['item'] == 'cd'){
      echo 'Add CD';

      if( $_POST['submit'] == 'add_cd'){
        if( $_POST['adult']? $adult = 0 : $adult = 1);
        $_POST = strip_sym($_POST);
        $sql = "INSERT INTO cds(title, artist, genre, adult) 
          VALUES('".$_POST['title']."', '".$_POST['artist']."', '"
                   .$_POST['genre']."', ".$adult.")";
        var_dump($sql);
        $stmt = oci_parse($conn, $sql);
        $success = oci_execute($stmt);
        if( $success){
          echo '<h3>Your CD was added to the database</h3>';
        }else{
          echo 'What is this weak shit!?<br>Try again!</h3>';
        }
      }
      ?>
      <table id='form_table'>
        <form action='add.php?item=cd' method='POST' id='add_form'>
        <tr>
          <td>Title:</td><td><input type='text' name='title'></td>
        </tr><tr>
          <td>Artist:</td><td><input type='text' name='artist'></td>
        </tr><tr>
          <td>Genre:</td><td><input type='text' name='genre'></td>
        </tr><tr>
          <td>Kid Safe?</td><td><input type='checkbox' name='adult'></td>
        </tr><tr>
          <td></td><td><input type='submit' name='submit' value='add_cd'></td></tr>
        </form>
      </table>
      <?php


    }elseif( $_GET['item'] == 'movie'){
      echo 'Add Movie';

      if( $_POST['submit'] == 'add_movie'){
        if( $_POST['adult']? $adult = 0 : $adult = 1);
        $_POST = strip_sym($_POST);
        $sql = "INSERT INTO movies(title, rating, format, sumry, adult)
                VALUES('".$_POST['title']."', '".$_POST['rating']."', '".$_POST['format']."', '"
                         .$_POST['sumry']."', ".$adult.")";
        var_dump($sql);
        $stmt = oci_parse($conn, $sql);
        $success = oci_execute($stmt);
        if( $success){
          echo '<h3>Your movie was added to the database</h3>';
        }else{
          echo '<h3>What is this weak shit!?<br>Try again!</h3>';
        }
      }
       ?>
        <table id='for_table'>
          <form action='add.php?item=movie' method='POST' id='add_form'>
          <tr>
            <td>Title:</td><td><input type='text' name='title'></td>
          </tr><tr>
            <td>Rating:</td><td><input type='text' name='rating'></td>
          </tr><tr>
            <td>Format:</td><td><input type='text' name='format'></td>
          </tr><tr>
            <td>Summary:</td><td><input type='text' name='sumry'></td>
          </tr><tr>
            <td>Kid Safe?</td><td><input type='checkbox' name='adult'</td>
          </tr><tr>
            <td></td><td><input type='submit' name='submit' value='add_movie'></td></tr>
          </form>
        </table>
      <?php
          

    }else
      echo 'GTFO!!';
  }else{
    echo 'GTFO!!';
  }
?>
</body>
</html>
