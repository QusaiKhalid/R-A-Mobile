import 'package:flutter/material.dart';
import 'api_service.dart';  // Import the APIService
import 'log_sheet_model.dart';  // Import the LogSheet model

class LogSheetPage extends StatefulWidget {
  @override
  _LogSheetPageState createState() => _LogSheetPageState();
}

class _LogSheetPageState extends State<LogSheetPage> {
  List<LogSheet> logSheets = [];  // List to hold LogSheet data
  bool isLoading = true;  // Track loading state

  @override
  void initState() {
    super.initState();
    _loadLogSheets();  // Load data when the widget is initialized
  }

  // Function to fetch data
  Future<void> _loadLogSheets() async {
    try {
      List<LogSheet> fetchedLogSheets = await APIService().fetchLogSheets();
      setState(() {
        logSheets = fetchedLogSheets;  // Update the list with fetched data
        isLoading = false;  // Set loading to false once data is loaded
      });
    } catch (e) {
      setState(() {
        isLoading = false;  // Set loading to false even if an error occurs
      });
      print('Error: $e');  // You can handle errors here (e.g., show an error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log Sheets')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())  // Show loader while data is being fetched
          : logSheets.isEmpty
              ? Center(child: Text('No log sheets available.'))  // Show message if no data
              : ListView.builder(
                  itemCount: logSheets.length,
                  itemBuilder: (context, index) {
                    LogSheet logSheet = logSheets[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Text(logSheet.nameOfPlane, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Flight No: ${logSheet.noOfFlight}'),
                            Text('Start Date: ${logSheet.startDate}'),
                            Text('End Date: ${logSheet.endDate}'),
                            Text('Takeoff Time: ${logSheet.takeOffTime}'),
                            Text('Landing Time: ${logSheet.landingTime}'),
                            Text('Departure: ${logSheet.departure}'),
                            Text('Arrival: ${logSheet.arrival}'),
                          ],
                        ),
                        onTap: () {
                          // Handle item tap (for example, navigate to a detail page)
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
