import 'dart:convert';
import 'package:http/http.dart' as http;
import 'log_sheet_model.dart'; // Import the LogSheet model here

class APIService {
  // final String baseUrl = 'http://10.0.2.2:8000/api/v1/';
  final Duration timeoutDuration = Duration(seconds: 300);
  // Fetch all LogSheets (index)
  Future<List<LogSheet>> fetchLogSheets() async {
  try {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/V1/logSheets'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 404) {
      print('404 Not Found! Check your API URL or server.');
      return [];  // Return empty list if not found
    } else if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      print('Data: $data');
      return data.map((item) => LogSheet.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load LogSheets: ${response.body}');
    }
    } catch (e) {
      print('Error: $e');
      return [];  // Return empty list in case of any error
    }
  }



  // Fetch a single LogSheet by ID (show)
  // Future<LogSheet> fetchLogSheetById(int id) async {
  //   final response = await http.get(Uri.parse('${baseUrl}logSheets/$id'));

  //   if (response.statusCode == 200) {
  //     return LogSheet.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load LogSheet');
  //   }
  // }
}
