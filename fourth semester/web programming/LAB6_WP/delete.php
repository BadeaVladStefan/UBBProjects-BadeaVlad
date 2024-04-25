<?php
include ('database/connection.php');
session_start();
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $connection = OpenConnection();
    if(isset($_POST['id']) && !empty($_POST['id'])) {
        $id = $connection->real_escape_string($_POST['id']);
        $stmt = $connection->prepare("DELETE FROM document WHERE id=?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
    }
    CloseConnection($connection);
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
<br>

<section class="display_delete">
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
                            <button class='btnDelete' type='button' onclick='confirmDelete(" . $row['id'] . ")'>Delete</button>
                      </td>
                      </tr>";
            }
            CloseConnection($con);
            ?>

        </tbody>
    </table>
</section>

<script>
function confirmDelete(id) {
    if(confirm("Are you sure you want to delete this document?")) {
        $.post("delete.php", {'id': id});
        location.reload();
    }
}
</script>

</body>
</html>
