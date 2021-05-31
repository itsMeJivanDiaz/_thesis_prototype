<?php

define('DB_SERVER', 'localhost');
define('DB_USER', 'root');
define('DB_PASSWORD', '');
define('DB_NAME', 'cimo');

$conn = mysqli_connect(DB_SERVER, DB_USER, DB_PASSWORD, DB_NAME);

/*if($conn){
    echo 'Connected to CIMO Database.';
}else{
    echo 'Something went wrong: ' . mysqli_connect_error(); 
}*/

?>