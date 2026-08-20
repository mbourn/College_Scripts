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
<div id='main'>
<?php
  render_mmbr_header();
  if(!empty($_SESSION['LoggedIn']) && !empty($_SESSION['Username'])){
    if( $_POST['find']){
      $_POST = strip_sym($_POST);
      if( $_POST['find'] == 'search'){
        //echo '<h1>Searching</h1>';

        if( ($_POST['table'] == 'books'  && $_POST['col'] == 'artist') || 
            ($_POST['table'] == 'cds'    && $_POST['col'] == 'auth')   ||
            ($_POST['table'] == 'movies' && $_POST['col'] == 'artist') ||
            ($_POST['table'] == 'movies' && $_POST['col'] == 'auth')){
          echo '<h1>Smart Ass</h1>';
        }elseif( !$_POST['term']){
          echo '<h3>It\'s true, my biceps can read your mind, <br>';
          echo 'but you still have to enter a search term.';
        }else{
          $sql = "SELECT * FROM ".$_POST['table']." WHERE ".$_POST['col']." = '".$_POST['term']."'";
          $result = oci_parse($conn, $sql);
          $success = oci_execute($result);
        }
      }elseif( $_POST['find'] == 'adultsonly'){
        echo '<h1>For The Grownups</h1>';

      }elseif( $_POST['find'] == 'kidsonly'){
        echo '<h1>For The Kiddies</h1>';

      }else{
        echo '<h3>WFT Happened!?</h3>';
      }
      if( !$success){
        echo '<h3>Guess What I Found?</h3>';
        echo '<h1>Nothing!</h1>Try again.<br>';
      }else{
        echo '<h3>Here\'s What I Found</h3><hr>';
        if( $_POST['table'] == 'books'){
          echo '<table><tr><th>Book No.</th><th>Title</th><th>Author</th><th>ISBN</th><th>';
          echo 'Kid Friendly</th>';
        }elseif( $_POST['table'] == 'cds'){
          echo '<table><tr><th>CD No.</th><th>Title</th><th>Artist</th><th>Genre</th>';
          echo '<th>Kid Friendly</th>';
        }else{
          echo '<table><tr><th>Movie No.</th><th>Title</th><th>Rating</th><th>Format</th>';
          echo '<th>Summary</th><th>Kid Friendly</th>';
        }
        echo '<th>Purge This Weakness</th><tr>';
        while( $row = oci_fetch_array($result, OCI_ASSOC+OCI_RETURN_NULLS)){
          foreach($row as $key => $value ){
            echo '<td>'.$value.'</td>';
          }
 //         $action = "if(confirm('Confirm Delete?')==true)";
          $action .= "location.href='delete.php?table=".$_POST['table'];
          $action .= "&col=id&term=".$row['ID']."';";
          echo '<td><button onclick="'.$action.'">PURGE!</button></td>';
          echo '</tr><tr>';
        }
        echo '</tr></table>';
        echo '<hr>';
      }
    }
?>
    <table id='form_table'>
      <form action='find.php' method='POST' id='find_form'>
      <tr>
        <td><select name='table' form='find_form'>
              <option value='books'>Book</option>
              <option value='cds'>CD</option>
              <option value='movies'>Movie</option>
            </select></td>  
        <td><select name='col' form='find_form'>
              <option value='title'>Title</option>
              <option value='artist'>Artist(for songs)</option>
              <option value='auth'>Author(for books)</option>
            </select></td>
      </td><tr>
        <td>Search Term: </td><td><input type='text' name='term'></td>
        <td colspan=2><input type='submit' name='find' value='search'></td>
      </tr><tr>
        <td colspan=2> ----------------------= OR =----------------------</td>
      </tr><tr>
        <td>Find All  <input type='submit' name='find' value='adults_only'></td>
        <td>Find All  <input type='submit' name='find' value='kids_only'></td>
      </tr>
      </form>
    </table>
              

<?php
  }else{
    echo ' <h1>GTFO!!</h1>';
  }
?>
</div>
</body>
</html>
