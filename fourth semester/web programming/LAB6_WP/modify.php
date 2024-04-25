<?php
use FTP\Connection;
session_start();
include ('database/connection.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $con = OpenConnection();
    if(isset($_POST['update'])){
        $author = validate_input($_POST['author']);
        $numberPages = validate_input($_POST['numberPages']);
        $type = validate_input($_POST['type']);
        $format = validate_input($_POST['format']);
        $title = validate_input($_POST['title']); 
        
        if (!empty($author) && !empty($numberPages) && !empty($type) && !empty($format) && !empty($title)  && $numberPages > 0 && is_numeric($numberPages)) {
            $stmt = $con->prepare("UPDATE document SET author=?, numberPages=?, type=?, format=? WHERE title=?");
            $stmt->bind_param("sisss", $author, $numberPages, $type, $format, $title); 
            $stmt->execute();
        } else {
            echo "Invalid Input.";
        }
    }
    CloseConnection($con);
}

function validate_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Documents Processing </title>
    <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script type="text/javascript" src="script.js"></script>
</head>

<body>
<button class="home" type="button" onclick="location.href='./index.html'">HOME </button>
<section class="update_form">
    <form action="modify.php" method="post">
        <input id="title" type="hidden" name="title" value="<?php echo isset($_POST['title']) ? $_POST['title'] : ''; ?>">
        <input id="author" type="text" name="author" placeholder="author">
        <input id="numberPages" type="text" name="numberPages" placeholder="numberPages">
        <input id="type" type="text" name="type" placeholder="type">
        <input id="format" type="text" name="format" placeholder="format">
        <input id="update" type="submit" name="update" value="Update document">
    </form>
</section>

<section class="display_modify">
    <br>
    <table class="display-table">
        <thead>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>NumberPages</th>
            <th>Type</th>
            <th>Format</th>
            <th> </th>
        </thead>
        <tbody>

            <?php
            $con = OpenConnection();
            $result_set = mysqli_query($con, "SELECT * FROM document");
            
            while($row = mysqli_fetch_array($result_set)){
                echo "<tr>";
                echo  "<td>" . $row['id'] . "</td>";
                echo  "<td>" . $row['title'] . "</td>";
                echo  "<td>" . $row['author'] . "</td>";
                echo  "<td>" . $row['numberPages'] . "</td>";
                echo  "<td>" . $row['type'] . "</td>";
                echo  "<td>" . $row['format'] . "</td>";
                echo  "<td> 
                            <button class='btnUpdate' type='button'>Update</button>
                      </td>
                      </tr>";
            }
            CloseConnection($con);
            ?>

        </tbody>
    </table>
</section>

</body>

</html>
