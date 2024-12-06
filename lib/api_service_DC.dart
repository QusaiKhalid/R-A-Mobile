import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DateC {
  final int id;
  final String name;
  final int serial;
  final String start;
  final String max;

  DateC({
    required this.id,
    required this.name,
    required this.serial,
    required this.start,
    required this.max,
  });

  factory DateC.fromJson(Map<String, dynamic> json) {
    return DateC(
      id: json['id'],
      name: json['name'],
      serial: json['serial'],
      start: json['start'],
      max: json['max'],
    );
  }
}

class APIServiceDC {
  final String baseUrl = 'http://10.0.2.2:8000/api/V1/DateC'; // Updated URL

  Future<List<DateC>> fetchDateCRecords(int page) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?page=$page'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data']; // Accessing 'data' from JSON
        return data.map((item) => DateC.fromJson(item)).toList();
      } else {
        // Log detailed error info
        print('Failed to load DateC records. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to load DateC records');
      }
    } catch (e) {
      // Print error message for debugging
      print('Error: $e');
      return [];
    }
  }
  Future<int> fetchCycleARowCount() async {
  try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/V1/DateC'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extract the total row count from the meta object
        return data['meta']['total'] ?? 0;
      } else {
        print('API Error: ${response.statusCode}, ${response.body}');
        return 0;
      }
    } catch (e) {
      print('Error fetching CycleA row count: $e');
      return 0;
    }
  }
}

Widget DC({
  required BuildContext context,
  required String title,
  required bool isDarkModeEnabled,
}) {
  final APIServiceDC apiServiceDC = APIServiceDC();

  return Container(
    margin: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          color: isDarkModeEnabled ? const Color(0x89000000) : const Color.fromRGBO(158, 158, 158, 1),
          offset: const Offset(4.0, 4.0),
          blurRadius: 15.0,
          spreadRadius: 1.0,
        ),
        BoxShadow(
          color: isDarkModeEnabled ? const Color.fromRGBO(66, 66, 66, 1) : const Color.fromRGBO(255, 255, 255, 1),
          offset: const Offset(-4.0, -4.0),
          blurRadius: 15.0,
          spreadRadius: 1.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Title centered
        Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        
        // Horizontal Scroll View with FutureBuilder
        Container(
          height: MediaQuery.of(context).size.height * 0.33,
          child: FutureBuilder<List<DateC>>(
            future: apiServiceDC.fetchDateCRecords(1), // Fetch first page of data
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text(
                              "No Critical Components",
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),);
              } else {
                List<DateC> dateCRecords = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(dateCRecords.length, (index) {
                      DateC dateA = dateCRecords[index];
                      return Container(
                        margin: const EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width * 0.7, // 70% of screen width
                        decoration: BoxDecoration(
                          color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: isDarkModeEnabled ? const Color(0x89000000) : const Color.fromRGBO(158, 158, 158, 1),
                              offset: const Offset(4.0, 4.0),
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                            ),
                            BoxShadow(
                              color: isDarkModeEnabled ? const Color.fromRGBO(66, 66, 66, 1) : const Color.fromRGBO(255, 255, 255, 1),
                              offset: const Offset(-4.0, -4.0),
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              dateA.name,
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Serial: ${dateA.serial}',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Start: ${dateA.start}',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Max: ${dateA.max}',
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
                    }),
                  ),
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}
