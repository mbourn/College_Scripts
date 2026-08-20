<!DOCTYPE html>
<html>
<head>
<?php require "base.php" ?>
<link rel='icon' href='favicon.png'>
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<body>
<div id="main">
<?php
if( !empty($_SESSION['LoggedIn']) && !empty($_SESSION['Username'])){
  render_mmbr_header();
  if( $_GET['action'] == 'add_collection'){
    create_collection($conn, $_POST['c_name'], $_POST['c_desc'], $_POST['adult']);
  }elseif( $_GET['delete']){
    delete_collection($conn, $_GET['delete']);
  }
  if( $_GET['action'] == 'create'){
    echo '<h1>Create Collection</h1>';
    var_dump($_SESSION);
?>
  <table id='create_form_table'>
    <form action='collections.php?action=add_collection' method='POST'>
    <tr>
      <td>Collection Name: </td>
      <td><input type='text' name='c_name' id='col_name'></td>
    </tr><tr>
      <td>Collection Description: </td>
      <td><input type='text' name='c_desc' id='col_desc'></td>
    </tr><tr>
      <td>Not Kid Safe? </td>
      <td><input type='checkbox' name='adult' id='adult'></td>
    </tr><tr>
      <td><input type='submit' name='submit' id='submit'></td>
    </tr></form>
  </table>

<?php
  }else{
    $sql = 'SELECT * FROM collections WHERE u_id = '.$_SESSION['id'];
    $stmt = oci_parse($conn, $sql);
    $success = oci_execute($stmt);
?>
    <div id="coll">
      <h3>Your Collections</h3>
      <table>
      <?php
        while( $row = oci_fetch_array( $stmt, OCI_ASSOC+OCI_RETURN_NULLS)){
          echo '<tr><td>'.$row['C_NAME'].'</td>';
          echo '<td><a href="collections.php?view='.$row['ID'].'">View</a></td>';
          echo '<td><a href="edit_collection.php?id='.$row['ID'].'">Edit</a></td>';
          echo '<td><a href="collections.php?delete='.$row['ID'].'">Delete</a></td>';
          echo '<td><a href="manage_collections.php?share='.$row['ID'].'">Share</a></td></tr>';
        }
      ?>
        </tr><tr>
          <td><a href="collections.php?action=create">Make a new Collections</a></td>
        </tr>
      </table>
    </div>
<?php
  }
}else{
  echo '<h1>GTFO!!</h1>';
}
?>
</div>
</body>
</html>
