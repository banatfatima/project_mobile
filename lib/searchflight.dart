import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchFlight extends StatefulWidget {
  const SearchFlight({Key? key}) : super(key: key);

  @override
  State<SearchFlight> createState() => _SearchFlightState();
}

class _SearchFlightState extends State<SearchFlight> {
  final TextEditingController _controllerFlightID = TextEditingController();
  String _flightInfo = '';

  @override
  void dispose() {
    _controllerFlightID.dispose();
    super.dispose();
  }

  void updateFlightInfo(String info) {
    setState(() {
      _flightInfo = info;
    });
  }

  Future<void> searchFlight(int flightId) async {
    final url = 'https://bariamikawi.000webhostapp.com/searchFlight.php';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'flightId': flightId});

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        if (result['status'] == 'success') {
          final flight = result['flight'];
          updateFlightInfo('Flight ID: ${flight['id']}\n'
              'Flight Number: ${flight['flight_number']}\n'
              'Departure Airport: ${flight['departure_airport']}\n'
              'Arrival Airport: ${flight['arrival_airport']}\n'
              'Departure Time: ${flight['departure_time']}\n'
              'Arrival Time: ${flight['arrival_time']}\n'
              'Available Seats: ${flight['available_seats']}\n'
              'Price: ${flight['price']}');
        } else {
          updateFlightInfo('Flight not found');
        }
      } else {
        updateFlightInfo('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      updateFlightInfo('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Search'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _controllerFlightID,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Flight ID',
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                try {
                  int flightId = int.parse(_controllerFlightID.text);
                  searchFlight(flightId);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid Flight ID')),
                  );
                }
              },
              child: const Text('Search', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 200,
                child: Flexible(
                  child: Text(
                    _flightInfo,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}