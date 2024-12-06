import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogSheetViewer extends StatelessWidget {
  final Map<String, dynamic> jsonData;
  final bool isDarkModeEnabled;

  const LogSheetViewer({
    Key? key,
    required this.jsonData,
    required this.isDarkModeEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extracting the flight data from the JSON
    final List flights = jsonData['data'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Log Sheets",
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: isDarkModeEnabled ? Colors.black : Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: flights.length,
        itemBuilder: (context, index) {
          final flight = flights[index];
          return buildLogSheet(
            flightNumber: flight['noOfFlight'] ?? 'N/A',
            captain: flight['nameOfPlane'] ?? 'Unknown',
            duration: '${flight['takeOffTime']} - ${flight['landingTime']}',
            from: flight['departure'] ?? 'Unknown',
            to: flight['arrival'] ?? 'Unknown',
            isDarkModeEnabled: isDarkModeEnabled,
          );
        },
      ),
    );
  }

  Widget buildLogSheet({
    required String flightNumber,
    required String captain,
    required String duration,
    required String from,
    required String to,
    required bool isDarkModeEnabled,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: isDarkModeEnabled
                ? const Color(0x89000000)
                : const Color.fromRGBO(158, 158, 158, 1),
            offset: const Offset(4.0, 4.0),
            blurRadius: 10.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Flight Number: $flightNumber",
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Captain: $captain",
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Duration: $duration",
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "From: $from",
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            "To: $to",
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
