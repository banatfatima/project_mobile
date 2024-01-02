import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:project_uni/booking_flight.dart';
import 'package:project_uni/item_flight.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_uni/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'searchflight.dart';

class FlightController {
  final flightRepo = FlightRepo();

  Future<List<Flight>> getflight() async {
    final response = await flightRepo.getflight();

    if (response.statusCode != 200) {
      print('Error: ${response.statusCode}');

      return [];
    }

    try {
      final jsonDataStartIndex = response.body.indexOf('{');
      final jsonData = response.body.substring(jsonDataStartIndex);
      final data = jsonDecode(jsonData);

      if (data is Map<String, dynamic> && data.containsKey('flights')) {
        final flightsJson = data['flights'];
        // print(data['flights']);

        if (flightsJson is List<dynamic>) {
          List<Flight> flights = [];

          for (dynamic flightJson in flightsJson) {
            print(flightJson);
            flights.add(Flight.fromJson(flightJson));
            print(1);
          }

          return flights;
        } else {
          print('Error: "flights" is not a List');

          return [];
        }
      } else {
        print('Error: Invalid JSON format');

        return [];
      }
    } catch (e) {
      print('Error decoding JSON: $e');

      return [];
    }
  }
}

class FlightData {
  List<Flight> flights;

  FlightData({required this.flights});

  factory FlightData.fromJson(Map<String, dynamic> json) {
    return FlightData(
      flights: (json['flights'] as List<dynamic>)
          .map((flightJson) => Flight.fromJson(flightJson))
          .toList(),
    );
  }
}

class FlightRepo {
  Future<http.Response> getflight() async {
    final url = Uri.parse('https://fbanat.000webhostapp.com/getflights.php');
    final response = await http.get(url);
    print('API Response: ${response.body}');
    return response;
  }
}

class FlightListWidget extends StatelessWidget {
  final List<Flight> flights;

  FlightListWidget({required this.flights});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: flights.length,
      itemBuilder: (context, index) {
        Flight flightData = flights[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: ListTile(
            contentPadding: EdgeInsets.all(15.0),
            title: Text(
              'Flight Number: ${flightData.flightNumber}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  'Departure Airport: ${flightData.departureAirport}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'Arrival Airport: ${flightData.arrivalAirport}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'Departure Time: ${flightData.departureTime}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Arrival Time: ${flightData.arrivalTime}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Available Seats: ${flightData.availableSeats}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Price: \$${flightData.price}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Flight>> _flights;

  @override
  void initState() {
    super.initState();
    _flights = FlightController().getflight();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 46, 45, 45),
              fontStyle: FontStyle.italic,
            ),
            children: [
              TextSpan(
                text: 'SAFRA',
                style: TextStyle(
                  color: Color.fromARGB(255, 31, 93, 163),
                  fontStyle: FontStyle.normal,
                ),
              ),
              TextSpan(text: ' AIRLINE'),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
              sp.remove('user_data');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AccountUs()),
              );
            },
            child: const Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 190,
            child: ImageSlideshow(
              indicatorColor: const Color.fromARGB(255, 243, 33, 33),
              onPageChanged: (value) {
                debugPrint('Page changed: $value');
              },
              autoPlayInterval: 2500,
              isLoop: true,
              children: [
                Image.asset(
                  'assests/a1.jpg',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assests/a2.jpg',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchFlight()),
              );
            },
            child: const Text('Search Flight'),
          ),
          Expanded(
            child: FutureBuilder(
              future: _flights,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData || !(snapshot.data is List<Flight>)) {
                  return const Center(
                    child: Text('No data available'),
                  );
                }

                List<Flight> flights = snapshot.data as List<Flight>;

                return ListView.builder(
                  itemCount: flights.length,
                  itemBuilder: (context, index) {
                    return ItemFlight(
                      flight: flights[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
