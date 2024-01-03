<?php
include("db_connection.php");

$response = ['status' => 'error', 'message' => 'Invalid request'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $flightId = $data['flightId'];

    $sql = "SELECT * FROM flights WHERE id = ?";
    $stmt = $con->prepare($sql);

    if ($stmt) {
        $stmt->bind_param("i", $flightId);

        if ($stmt->execute()) {
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $flight = $result->fetch_assoc();
                $response = ['status' => 'success', 'flight' => $flight];
            } else {
                $response = ['status' => 'error', 'message' => 'Flight not found'];
            }
        } else {
            $response = ['status' => 'error', 'message' => 'Error executing query: ' . $stmt->error];
        }

        $stmt->close();
    } else {
        $response = ['status' => 'error', 'message' => 'Error preparing statement: ' . $con->error];
    }
} else {
    http_response_code(405); // Method Not Allowed
    $response = ['status' => 'error', 'message' => 'Method not allowed'];
}

$con->close();
echo json_encode($response);
?>
