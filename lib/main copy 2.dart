import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qusai_final_project/engineer_page.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
List<String> notificationsList = [];  // Keep this list for storing notification messages

// Initialize the local notifications
Future<void> initializeNotifications() async {
  print("Initializing notifications...");
  
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Notification channel for Android 8.0+
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'your_channel_id', // id
    'your_channel_name', // name
    description: 'Your channel description',
    importance: Importance.high,
  );

  // Initialize notification settings with the channel
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  print("Notifications initialized.");
}


// Show the notification
Future<void> showNotification(String title, String body, int notificationId) async {
  print("Showing notification: $title, $body");

  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    channelDescription: 'Your channel description',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidNotificationDetails);

  // Add the notification to the list
  notificationsList.add('$title: $body');

  // Show the notification with a unique ID
  await flutterLocalNotificationsPlugin.show(
    notificationId,  // Use a unique ID for each notification
    title,
    body,
    platformChannelSpecifics,
    payload: 'item x',
  );
  print("Notification displayed: $title");
}

// Fetch notifications from the API
Future<List<Map<String, dynamic>>> fetchNotifications() async {
  print("Fetching notifications from API...");
  try {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/V1/notifications'));

    if (response.statusCode == 200) {
      // Decode the response and access the 'data' field
      Map<String, dynamic> responseBody = json.decode(response.body);
      List<dynamic> data = responseBody['data'];
      print("Fetched ${data.length} notifications.");
      return List<Map<String, dynamic>>.from(data);
    } else {
      print("Failed to load notifications. Status code: ${response.statusCode}");
      throw Exception('Failed to load notifications');
    }
  } catch (e) {
    print('Error fetching notifications: $e');
    return [];
  }
}

// Load the list of notifications from shared preferences
Future<void> loadNotificationsList() async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? savedNotifications = prefs.getStringList('notificationsList');
  
  if (savedNotifications != null) {
    notificationsList = savedNotifications;
  }
}

// Save the notifications list to shared preferences
Future<void> saveNotificationsList() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('notificationsList', notificationsList);
}

// Start the periodic timer to fetch notifications every 10 minutes
void startNotificationTimer() {
  print("Starting notification timer...");
  Timer.periodic(Duration(minutes: 10), (timer) async {
    print("Timer triggered, fetching notifications...");
    List<Map<String, dynamic>> notifications = await fetchNotifications();

    // Only send notifications where 'isRead' is false (0) and not already in the list
    for (var notification in notifications) {
      if (notification['isRead'] == 0) {
        String notificationMessage = notification['message'];
        int notificationId = notification['id']; // Use 'id' as a unique notification ID

        // Check if the notification is already in the list
        if (!notificationsList.contains('$notificationMessage: Record ID: ${notification['recordId']}')) {
          // If not, show the notification and add it to the list
          showNotification(notificationMessage, 'Record ID: ${notification['recordId']}', notificationId);

          // Add the notification to the list
          notificationsList.add('$notificationMessage: Record ID: ${notification['recordId']}');

          // Save the updated notifications list
          saveNotificationsList();
        } else {
          print("Notification already in the list: $notificationMessage");
        }
      }
    }
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize notifications, load notifications list, and start the timer for periodic fetching
    initializeNotifications();
    loadNotificationsList();  // Load previously saved notifications list
    startNotificationTimer();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: EngineerPage(),
    );
  }
}
