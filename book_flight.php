<?php

require_once 'db_connection.php'; // Assuming you have a separate file for database connection

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Assuming your data is sent as JSON
    $data = json_decode(file_get_contents('php://input'), true);

    // Access the data
    $userId = $data['userId'];
    $flightId = $data['flightId'];
    $passengerName = $data['passengerName'];
    $numberOfAdults = $data['numberOfAdults'];
    $numberOfChildren = $data['numberOfChildren'];
    // $departureDate = $data['departureDate'];
    // $arrivalDate = $data['arrivalDate'];
    $passengerSeat = $data['passengerSeat'];
    $hasInsurance = $data['hasInsurance'];
    $selectedClass = $data['selectedClass'];
    $isRoundTrip = $data['isRoundTrip'];

    // Insert data into the database using prepared statements
    $stmt = $con->prepare("INSERT INTO bookings (user_id, flight_id, passenger_name, number_of_adults, number_of_children, passenger_seat, has_insurance, selected_class, is_round_trip) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $stmt->bind_param("iissiisss",$userId, $flightId, $passengerName, $numberOfAdults, $numberOfChildren, $passengerSeat, $hasInsurance, $selectedClass, $isRoundTrip);

    // Execute the query
    if ($stmt->execute()) {
        $response = ['status' => 'success', 'message' => 'Booking successful'];
    } else {
        $response = ['status' => 'error', 'message' => 'Error inserting data: ' . $stmt->error];
    }

    // Close the statement
    $stmt->close();
} else {
    // Handle other HTTP methods if needed
    http_response_code(405); // Method Not Allowed
    $response = ['status' => 'error', 'message' => 'Method not allowed'];
}

// Close the database connection
$con->close();

// Send the JSON response
echo json_encode($response);
?>