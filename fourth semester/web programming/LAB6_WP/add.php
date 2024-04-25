<?php
session_start();
include('database/connection.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $title = validate_input($_POST['title']);
    $author = validate_input($_POST['author']);
    $numberPages = validate_input($_POST['numberPages']);
    $type = validate_input($_POST['type']);
    $format = validate_input($_POST['format']);

    if (!empty($title) && !empty($author) && !empty($numberPages) && !empty($type) && !empty($format) && $numberPages > 0 && is_numeric($numberPages)) {
        $con = OpenConnection();
        $stmt = $con->prepare("INSERT INTO document(title, author, numberPages, type, format) VALUES(?, ?, ?, ?, ?)");
        $stmt->bind_param("ssiss", $title, $author, $numberPages, $type, $format);
        $stmt->execute();
        CloseConnection($con);
    } else {
        echo "Invalid Input.";
    }
}

function validate_input($data) {
    return htmlspecialchars(stripslashes(trim($data)));
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Documents Processing</title>
    <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<button class="home" type="button" onclick="location.href='./index.html'">HOME</button>
<br>
<section class="add_form">
    <form action="add.php" method="post">
        <input id="title" type="text" name="title" placeholder="Title">
        <input id="author" type="text" name="author" placeholder="Author">
        <input id="numberPages" type="number" name="numberPages" placeholder="Number of Pages" min="1">
        <input id="type" type="text" name="type" placeholder="Type">
        <input id="format" type="text" name="format" placeholder="Format">
        <input id="add" type="submit" name="add" value="Add New Document">
    </form>
</section>
<section class="display_add">
    <br>
    <table class="display-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Number of Pages</th>
                <th>Type</th>
                <th>Format</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $con = OpenConnection();
            $result_set = mysqli_query($con, "SELECT * FROM document");
            while ($row = mysqli_fetch_array($result_set)) {
                echo "<tr>";
                echo "<td>" . $row['id'] . "</td>";
                echo "<td>" . $row['title'] . "</td>";
                echo "<td>" . $row['author'] . "</td>";
                echo "<td>" . $row['numberPages'] . "</td>";
                echo "<td>" . $row['type'] . "</td>";
                echo "<td>" . $row['format'] . "</td>";
                echo "</tr>";
            }
            CloseConnection($con);
            ?>
        </tbody>
    </table>
</section>
</body>
</html>
