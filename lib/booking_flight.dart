import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'seatavailabilitypage.dart';

class Flight {
  String id;
  String flightNumber;
  String departureAirport;
  String arrivalAirport;
  String departureTime;
  String arrivalTime;
  String availableSeats;
  String price;

  Flight({
    required this.id,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.availableSeats,
    required this.price,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'],
      flightNumber: json['flight_number'],
      departureAirport: json['departure_airport'],
      arrivalAirport: json['arrival_airport'],
      departureTime: json['departure_time'],
      arrivalTime: json['arrival_time'],
      availableSeats: json['available_seats'],
      price: json['price'].toString(),
    );
  }
}

class BookingFlight extends StatefulWidget {
  final Flight flight;

  const BookingFlight({Key? key, required this.flight}) : super(key: key);

  @override
  State<BookingFlight> createState() => _BookingFlightState();
}

class _BookingFlightState extends State<BookingFlight> {
  bool hasInsurance = false;
  String passengerName = '';
  int numberOfAdults = 1;
  int numberOfChildren = 0;
  String selectedClass = 'Economy';
  bool isRoundTrip = true;

  TimeOfDay selectedDepartureTime = TimeOfDay.now();
  late DateTime arrival =
      DateFormat('yyyy-MM-dd HH:mm:ss').parse(widget.flight.arrivalTime);
  late DateTime departure =
      DateFormat('yyyy-MM-dd HH:mm:ss').parse(widget.flight.departureTime);
  late String arrivalDate = DateFormat('yyyy-MM-dd').format(arrival);
  late String arrivalTime = DateFormat('HH:mm:ss').format(arrival);
  late String departureDate = DateFormat('yyyy-MM-dd').format(departure);
  late String departureTime = DateFormat('HH:mm:ss').format(departure);
  int bagWeight = 20;
  String? passengerSeat;
  double getTotalCost() {
    // Assuming widget.flight.price is a String, parse it to double
    double baseCost = double.parse(widget.flight.price);

    // Calculate total number of persons (adults + children)
    int totalPersons = numberOfAdults + numberOfChildren;

    // Calculate total cost by multiplying base cost with total persons
    double totalCost = baseCost * totalPersons;

    return totalCost;
  }

  @override
  void initState() {
    print(widget.flight.departureTime);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> sendBookingDataToServer() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int userId = jsonDecode(sp.getString('user_data') ?? '{}')['id'];
    final Map<String, dynamic> bookingData = {
      'userId': userId,
      'flightId': widget.flight.id.toString(),
      'passengerName': passengerName,
      'numberOfAdults': numberOfAdults.toString(),
      'numberOfChildren': numberOfChildren.toString(),
      'passengerSeat': passengerSeat,
      'hasInsurance': hasInsurance ? '1' : '0',
      'selectedClass': selectedClass,
      'isRoundTrip': isRoundTrip ? '1' : '0',
    };
    print(jsonEncode(bookingData));
    final response = await http.post(
      Uri.parse('https://fbanat.000webhostapp.com/book_flight.php'),
      body: jsonEncode(bookingData),
    );

    print('Response Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
  }

  void showFinalCostDialog(BuildContext context) {
    double finalCost = getTotalCost();
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Booking Details'),
            content: Container(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  buildDetailItem(
                      'Selected Flight', widget.flight.flightNumber),
                  buildDetailItem(
                      'Departure Airport', widget.flight.departureAirport),
                  buildDetailItem(
                      'Arrival Airport', widget.flight.arrivalAirport),
                  buildDetailItem('Departure Time', departureTime),
                  buildDetailItem('Arrival Time', arrivalTime),
                  buildDetailItem('Passenger Name', passengerName),
                  buildDetailItem('Class', selectedClass),
                  buildDetailItem(
                      'Number of Adults', numberOfAdults.toString()),
                  buildDetailItem(
                      'Number of Children', numberOfChildren.toString()),
                  buildDetailItem(
                      'Ticket Type', isRoundTrip ? 'Round Trip' : 'One Way'),
                  buildDetailItem(
                      'Selected Seat', passengerSeat ?? 'Not selected'),
                  buildDetailItem('Departure Date', departureDate),
                  buildDetailItem('Departure Time', departureTime),
                  buildDetailItem('Arrival Date', arrivalDate),
                  buildDetailItem('Arrival Time', arrivalTime),
                  buildDetailItem('Bag Weight', '$bagWeight kg'),
                  buildDetailItem('Total Cost', '\$$finalCost'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await sendBookingDataToServer();
                  Navigator.of(context).pop();
                },
                child: Text('Confirm Booking'),
              ),
            ],
          );
        },
      );
    }
  }

  // double getTotalCost() {

  //   double baseCost =
  //       widget.flight.getTotalCost(numberOfAdults, numberOfChildren);
  //   double bagCost = bagWeight * 10.0;

  //   return baseCost + bagCost;
  // }

  Widget buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Flight Booking Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 8.0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Book Flight',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Selected Flight: ${widget.flight.flightNumber}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Passenger Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter passenger name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          passengerName = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Adults'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the number of adults';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                numberOfAdults = int.parse(value);
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Children'),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                numberOfChildren = int.parse(value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: selectedClass,
                      items: ['Economy', 'Business', 'First Class']
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedClass = value!;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Class'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Round Trip'),
                        Switch(
                          value: isRoundTrip,
                          onChanged: (value) {
                            setState(() {
                              isRoundTrip = value;
                            });
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Navigate to SeatAvailabilityPage and wait for seat selection
                        final selectedSeat = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeatAvailabilityPage(
                              flightDestination: widget.flight.departureAirport,
                            ),
                          ),
                        );

                        if (selectedSeat != null) {
                          setState(() {
                            // Set the selected seat in the booking details
                            passengerSeat = selectedSeat;
                          });

                          // Display a message or perform further actions if needed
                          print('Selected Seat: $selectedSeat');
                        }
                      },
                      child: Text('Check Seat Availability'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        showFinalCostDialog(context);
                      },
                      child: Text('Book Flight'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void confirmBooking(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Your flight has been booked successfully!'),
      duration: Duration(seconds: 3),
    ),
  );
}

Widget buildDetailItem(String label, String value) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ]));
}