<?php


include('db_connection.php'); // Include your database connection file

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT * FROM flights";
    $result = mysqli_query($con, $sql);

    if ($result) {
        $flights = array();

        while ($row = mysqli_fetch_assoc($result)) {
            $flights[] = $row;
        }

        echo json_encode(['success' => true, 'flights' => $flights]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error in query']);
    }

    mysqli_close($con);
} else {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}
?>