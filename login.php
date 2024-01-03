<?php

include('db_connection.php'); // Include your database connection file

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

$sql = "SELECT * FROM users WHERE email = ?";
$stmt = mysqli_prepare($con, $sql);

$email = mysqli_real_escape_string($con, $_POST['email']);
$password = mysqli_real_escape_string($con, $_POST['password']);

    if ($stmt) {
        mysqli_stmt_bind_param($stmt, "s", $email);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if ($result) {
            $row = mysqli_fetch_assoc($result);
            if ($row && password_verify($password, $row['password'])) {
    echo json_encode(['success' => true, 'user' => $row]);
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid email or password']);
}

        } else {
            echo json_encode(['success' => false, 'message' => 'Error in query']);
        }

        mysqli_stmt_close($stmt);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error in preparing statement']);
    }

    mysqli_close($con);
} else {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}
?>