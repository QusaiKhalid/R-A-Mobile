import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LogSheet {
  final int id;
  final String nameOfPlane;
  final int noOfFlight;
  final String departure;
  final String arrival;
  final String takeOffTime;
  final String landingTime;
  final String startDate;  // Added for start date
  final String endDate;    // Added for end date

  LogSheet({
    required this.id,
    required this.nameOfPlane,
    required this.noOfFlight,
    required this.departure,
    required this.arrival,
    required this.takeOffTime,
    required this.landingTime,
    required this.startDate,  // Add the start date
    required this.endDate,    // Add the end date
  });

  factory LogSheet.fromJson(Map<String, dynamic> json) {
  return LogSheet(
    id: json['id'] ?? 0,  // Handle null by providing a default value
    nameOfPlane: json['nameOfPlane'] ?? '',  // Default to empty string if null
    noOfFlight: int.tryParse(json['noOfFlight'] ?? '') ?? 0,  // Safely parse, fallback to 0 if null
    departure: json['departure'] ?? '',  // Default to empty string if null
    arrival: json['arrival'] ?? '',  // Default to empty string if null
    takeOffTime: json['takeOffTime'] ?? '',  // Default to empty string if null
    landingTime: json['landingTime'] ?? '',  // Default to empty string if null
    startDate: json['startDate'] ?? '',  // Default to empty string if null
    endDate: json['endDate'] ?? '',  // Default to empty string if null
  );
}
}

// Data being sent


class LogSheetAPI {
  final String baseUrl = 'http://10.0.2.2:8000/api/V1/logSheets';

  Future<List<LogSheet>> fetchLogSheets(int page) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?page=$page'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        return data.map((item) => LogSheet.fromJson(item)).toList();
      } else {
        print('Failed to load log sheets. Status Code: ${response.statusCode}');
        throw Exception('Failed to load log sheets');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
Future<void> submitLogSheet({
  required String planeDropDownValeu,
  required String flightTextValue,
  required String airpotsDropDownValeuDeparture,
  required String airpotsDropDownValeuArival,
  required DateTime departureDatetime,
  required DateTime arivalDatetime,
  required BuildContext context,
}) async {
  final newLogSheet = {
    'name_of_plane': planeDropDownValeu,  // Match field name
    'no_of_flight': int.parse(flightTextValue),  // Convert to integer
    'start_date': departureDatetime.toIso8601String().split('T')[0],  // Use only the date part
    'end_date': arivalDatetime.toIso8601String().split('T')[0],  // Use only the date part
    'departure': airpotsDropDownValeuDeparture,  // Match field name
    'arrival': airpotsDropDownValeuArival,  // Match field name
    'take_off_time': "${departureDatetime.hour}:${departureDatetime.minute.toString().padLeft(2, '0')}",  // Format as H:i
    'landing_time': "${arivalDatetime.hour}:${arivalDatetime.minute.toString().padLeft(2, '0')}",  // Format as H:i
  // Format as H:i
  };

  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/V1/logSheets'),
      headers: {
        'Content-Type': 'application/json',  // Specifies that we are sending JSON
        'Accept': 'application/json',        // Indicates that we expect a JSON response
      },
      body: json.encode(newLogSheet),  // JSON-encode the body data
    );

    // Check if the response is successful
    if (response.statusCode == 201) {
      print("LogSheet submitted successfully!");
    } else {
      // Handle different response status codes
      print("Failed to submit LogSheet: ${response.statusCode}");
      print("Error message: ${response.body}");
      throw Exception('Failed to submit LogSheet: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any error that occurs during the HTTP request
    print("Error occurred while submitting LogSheet: $e");
    // Optionally, show an alert or snackbar to the user
    throw Exception('Error occurred: $e');
    _showErrorDialog(context, 'An error occurred while submitting the log sheet: $e');
  }
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Widget buildLogSheet({
  required String flightNumber,
  required String Airplane,
  required String duration,
  required String from,
  required String to,
  required bool isDarkModeEnabled,
}) {
  double cardSize = 250.0; // Define the size for width and height of the card

  return Container(
    margin: const EdgeInsets.all(20),
    width: cardSize,
    height: cardSize, // Making width and height equal
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Flight number: $flightNumber",
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
              fontSize: 20,  // Updated to 20
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          "Airplane: $Airplane",
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
              fontSize: 20,  // Updated to 20
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.access_time, size: 20, color: isDarkModeEnabled ? Colors.white : Colors.black),  // Updated icon size to 20
            Text(
              duration,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                  fontSize: 20,  // Updated to 20
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Text(
          "From: $from",
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
              fontSize: 20,  // Updated to 20
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          "TO: $to",
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
              fontSize: 20,  // Updated to 20
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}


class LogSheetWidget extends StatefulWidget {
  final bool isDarkModeEnabled;
  final String? nameOfPlane ; // Added a new parameter to filter by name of plane
  const LogSheetWidget({
    Key? key,
    required this.isDarkModeEnabled,
    this.nameOfPlane, // Pass the name of the plane when the widget is used
  }) : super(key: key);

  @override
  _LogSheetWidgetState createState() => _LogSheetWidgetState();
}

class _LogSheetWidgetState extends State<LogSheetWidget> {
  final LogSheetAPI apiService = LogSheetAPI();
  List<LogSheet> logSheets = [];
  int currentPage = 1; // Start from the first page
  bool isLoading = false;
  bool hasMorePages = true;

  @override
  void initState() {
    super.initState();
    _fetchLogSheets();
  }

  Future<void> _fetchLogSheets() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch the log sheets for the current page
      List<LogSheet> newLogSheets = await apiService.fetchLogSheets(currentPage);

      // Filter by nameOfPlane if it's provided
      if (widget.nameOfPlane != null && widget.nameOfPlane!.isNotEmpty) {
        newLogSheets = newLogSheets
            .where((logSheet) => logSheet.nameOfPlane
                .toLowerCase()
                .contains(widget.nameOfPlane!.toLowerCase()))
            .toList();
      }

      if (newLogSheets.isEmpty) {
        setState(() {
          hasMorePages = false; // No more pages to load
        });
      } else {
        setState(() {
          logSheets = newLogSheets; // Replace the previous data with new page data
        });
      }
    } catch (e) {
      print('Error fetching log sheets: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  // Method to handle page navigation
  void _goToNextPage() {
    if (hasMorePages) {
      setState(() {
        currentPage++;
      });
      _fetchLogSheets(); // Fetch next page data
    }
  }

  void _goToPreviousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
      _fetchLogSheets(); // Fetch previous page data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: logSheets.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < logSheets.length) {
                  LogSheet logSheet = logSheets[index];
                  return buildLogSheet(
                    flightNumber: logSheet.noOfFlight.toString(),
                    Airplane: logSheet.nameOfPlane,
                    duration: "${logSheet.takeOffTime} - ${logSheet.landingTime}",
                    from: logSheet.departure,
                    to: logSheet.arrival,
                    isDarkModeEnabled: widget.isDarkModeEnabled,
                  );
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
          // Pagination controls
          if (!isLoading)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _goToPreviousPage,
                  color: widget.isDarkModeEnabled ? Colors.white : Colors.black,
                ),
                Text(
                  'Page $currentPage ',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      color: widget.isDarkModeEnabled ? Colors.white : Colors.black,
                      fontSize: 20,  // Updated to 20
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: _goToNextPage,
                  color: widget.isDarkModeEnabled ? Colors.white : Colors.black,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
