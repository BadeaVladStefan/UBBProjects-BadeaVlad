<?php
include ('database/connection.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Documents Browser</title>
    <script type="text/javascript" src="browse.js"></script>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>


    <button class="home" type="button" onclick="location.href='./index.html'">HOME</button>
    
    <div id="previous-filter">

    </div>

    <div id="main">
        <h1>Documents</h1>

        <div class="container">
            <h2>Types:</h2>
            <select id="select-type" name="Select Filter" onchange="get_filtered_by_type()">
                <?php
                $con = OpenConnection();
                $sql = "SELECT DISTINCT type FROM document";
                $result_set = $con->query($sql);

                if (mysqli_num_rows($result_set) > 0) {
                    while ($row = mysqli_fetch_array($result_set)) {
                        $type = '' . $row['type'] . '';
                        echo '<option>' . $type . '</option>';
                    }
                }
                CloseConnection($con);
                ?>
            </select>
        </div>

        <div class="container">
            <h2>Formats:</h2>
            <select id="select-format" name="Select Filter" onchange="get_filtered_by_format()">
                <?php
                $con = OpenConnection();
                $sql = "SELECT DISTINCT format FROM document";
                $result_set = $con->query($sql);

                if (mysqli_num_rows($result_set) > 0) {
                    while ($row = mysqli_fetch_array($result_set)) {
                        $format = '' . $row['format'] . '';
                        echo '<option>' . $format . '</option>';
                    }
                }
                CloseConnection($con)
                ?>
            </select>
        </div>

        <br>
        <button onclick="window.location.reload()">Remove Filters</button>
        <br>

        <table id="browse-table" class="browse-table">
            <thead>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>NumberPages</th>
                <th>Type</th>
                <th>Format</th>
            </thead>
            <tbody id="browse-tbody">
                <?php
                $con = OpenConnection();
                $result_set = mysqli_query($con, "SELECT * FROM document");

                while ($row = mysqli_fetch_array($result_set)) {
                    echo " <tr>";
                    echo  "<td>" . $row['id'] . "</td>";
                    echo  "<td>" . $row['title'] . "</td>";
                    echo  "<td>" . $row['author'] . "</td>";
                    echo  "<td>" . $row['numberPages'] . "</td>";
                    echo  "<td>" . $row['type'] . "</td>";
                    echo  "<td>" . $row['format'] . "</td>";
                    echo   "</tr>";
                }
                CloseConnection($con)
                ?>
            </tbody>
        </table>
    </div>
</body>

</html>
