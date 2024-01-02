import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SeatAvailabilityPage extends StatefulWidget {
  final String flightDestination;

  SeatAvailabilityPage({required this.flightDestination});

  @override
  _SeatAvailabilityPageState createState() => _SeatAvailabilityPageState();
}

class _SeatAvailabilityPageState extends State<SeatAvailabilityPage> {
  List<Map<String, dynamic>> availableSeats = [];
  String selectedSeat = '';

  @override
  void initState() {
    super.initState();
    fetchAvailableSeats();
  }

  Future<void> fetchAvailableSeats() async {
    final response = await http
        .get(Uri.parse('https://bariamikawi.000webhostapp.com/getSeats.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        availableSeats = List<Map<String, dynamic>>.from(data['seats']);
      });
    } else {
      throw Exception('Failed to fetch available seats');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Availability'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Available Seats for ${widget.flightDestination}:'),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: availableSeats.length,
                itemBuilder: (context, index) {
                  final seat = availableSeats[index];
                  final isSeatSelected = selectedSeat == seat['seatNumber'];

                  return GestureDetector(onTap: () {
                    // Pass the selected seat back to the previous page
                    Navigator.pop(context, seat['seatNumber']);
                    // Optionally, you can display a message or perform further actions here
                    print('Selected Seat: ${seat['seatNumber']}');
                  },
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSeatSelected ? Colors.blue : Colors.green,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Seat: ${seat['seatNumber']}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            'Occupied: ${seat['isOccupied'] == 1 ? 'Yes' : 'No'}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Seat: $selectedSeat',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
