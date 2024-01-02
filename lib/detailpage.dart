import 'package:flutter/material.dart';
import 'booking_flight.dart';

class DetailsPage extends StatelessWidget {
  final Flight flight;

  DetailsPage({required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assests/a2.jpg'), // Corrected asset path
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Text(
                  'SAFRA AIRLINES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  buildDetailRow(Icons.map, Colors.blue, 'Path of Trip'),
                  SizedBox(height: 16.0),
                  buildDetailRow(
                      Icons.flight, Colors.deepOrange, 'Flight Number: 4'),
                  SizedBox(height: 16.0),
                  buildDetailRow(Icons.location_on, Colors.green,
                      'From: ${flight.departureAirport}'),
                  SizedBox(height: 16.0),
                  buildDetailRow(Icons.location_on, Colors.red,
                      'To: ${flight.arrivalAirport}'),
                  SizedBox(height: 16.0),
                  buildDetailRow(Icons.access_time, Colors.black,
                      'Departure Time: ${flight.departureTime}'),
                  SizedBox(height: 16.0),
                  buildDetailRow(
                      Icons.attach_money,
                      Colors.green,
                      'Price: \$${flight.price}'),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingFlight(flight: flight),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      // Apply the ButtonStyle from the second button
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget buildDetailRow(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 28.0),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }
}