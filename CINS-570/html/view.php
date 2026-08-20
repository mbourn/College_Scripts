<!DOCTYPE html>
<head>
 <?php require "base.php" ?>
 <link rel="stylesheet" href="style.css" type="text/css">
 <link rel='icon' href='favicon.png'>
</head>
<body>
<?php render_mmbr_header();?>
<div id="main">
<?php
  if( !empty($_SESSION['LoggedIn']) && !empty($_SESSION['Username'])){
    if( $_GET['item'] == 'books' ){
      echo 'BOOKS';
      $sql = 'SELECT * FROM books';  
      $books = oci_parse($conn, $sql);
      oci_execute($books);
      oci_close($conn);

      echo '<table border=1>';
      echo '<tr><th>TITLE</th><th>AUTHOR</th><th>ISBN</th></tr>';
      while( $row = oci_fetch_array($books, OCI_ASSOC+OCI_RETURN_NULLS)){
        echo '<tr><td>'.$row['TITLE'].'</td><td>'.$row['AUTH'].'</td><td>'.$row['ISBN'].'</td></tr>';
      }
      echo '</table>';

    }elseif( $_GET['item'] == 'cds'){
      echo 'CDS';
      $sql = 'SELECT * FROM cds';
      $cds = oci_parse($conn, $sql);
      oci_execute($cds);
      oci_close($conn);

      echo'<table border=1>';
      echo '<tr><th>TITLE</th><th>ARTIST</th><th>GENRE</th></tr>';
      while( $row = oci_fetch_array($cds, OCI_ASSOC+OCI_RETURN_NULLS)){
        echo '<tr><td>'.$row['TITLE'].'</td><td>'.$row['ARTIST'].'</td><td>'.$row['GENRE'].'</td></tr>';
      }
      echo '</table>';

    }elseif( $_GET['item'] == 'movies'){
      echo 'MOVIES';
      $sql = 'SELECT * FROM movies';
      $movies = oci_parse($conn, $sql);
      oci_execute($movies);
      oci_close($conn);

      echo '<table border=1>';
      echo '<tr><th>TITLE</th><th>RATING</th><th>FORMAT</th><th>SUMMARY</th></tr>';
      while( $row = oci_fetch_array($movies, OCI_ASSOC+OCI_RETURN_NULLS)){
        echo'<tr><td>'.$row['TITLE'].'</td><td>'.$row['RATING'].'</td><td>'.$row['FORMAT'].'</td><td>'.$row['SUMRY'].'</td></tr>';
      }
      echo '</table>';



    }else{
      echo 'GTFO!!';
    }
  }else{
    echo 'GTFO!!';
  }
  







?>
</div>
</body>
</html>
