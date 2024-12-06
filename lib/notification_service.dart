import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  final String apiUrl = 'http://10.0.2.2/api/V1/notifications';

  // Function to send notification data to the Laravel API
  Future<void> sendNotification(String message, int recordId) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'message': message,
          'record_id': recordId,
        }),
      );

      if (response.statusCode == 201) {
        print('Notification sent successfully!');
      } else {
        print('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  // Function to fetch notifications from the API
  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> notifications = json.decode(response.body);
        return notifications.map((notification) => Map<String, dynamic>.from(notification)).toList();
      } else {
        print('Failed to fetch notifications: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
  }
}
