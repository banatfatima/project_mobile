import 'package:flutter/material.dart';
import 'package:project_uni/detailpage.dart';


import 'booking_flight.dart';

class ItemFlight extends StatelessWidget {
  final Flight flight;

  const ItemFlight({
    required this.flight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(flight: flight),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.flight_takeoff, color: Colors.green, size: 28.0),
                  SizedBox(width: 8.0),
                  Text(
                    'From: ${flight.departureAirport}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.flight_land, color: Colors.red, size: 28.0),
                  SizedBox(width: 8.0),
                  Text(
                    'To: ${flight.arrivalAirport}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.black, size: 28.0),
                  SizedBox(width: 8.0),
                  Text(
                    'Date: ${flight.departureTime}',
                    style: TextStyle(fontSize: 18.0),
                  ),  SizedBox(width: 8.0),

                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.monetization_on),
                  Text(
                    'Price: \$${flight.price}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}