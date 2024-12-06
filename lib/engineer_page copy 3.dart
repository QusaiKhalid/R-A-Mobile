import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:qusai_final_project/api_service_CB.dart';
import 'package:qusai_final_project/api_service_CC.dart';
import 'package:qusai_final_project/api_service_DC.dart';
import 'package:qusai_final_project/api_service_HA.dart';
import 'package:qusai_final_project/api_service_HC.dart';
import 'package:qusai_final_project/api_service_Hb.dart';
import 'package:qusai_final_project/login_page.dart';

import 'api_service_CA.dart';
import 'api_service_DA.dart';
import 'api_service_DB.dart';
import 'engineer_app_bar_1.dart';
import 'api_servise_log_sheet.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EngineerPage extends StatefulWidget {
  const EngineerPage({super.key});

  @override
  State<EngineerPage> createState() => _EngineerPageState();
}

int totalHours = rowCountHA+rowCountHB+rowCountHC;
int totalDate = rowCountDA+rowCountDB+rowCountDC;
int totalCycles = rowCountCA+rowCountCB+rowCountCC;
class _EngineerPageState extends State<EngineerPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  List<String> notificationsList = [];
  String titleMain = 'A380';
  int hours =0;
  int cycles =0;
  
  @override
  void initState() {
    super.initState();
    initializeNotifications();
    loadNotificationsList();
    startNotificationTimer();
  }

  Future<void> initializeNotifications() async {
    print("Initializing notifications...");

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your_channel_id', // id
      'your_channel_name', // name
      description: 'Your channel description',
      importance: Importance.high,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    print("Notifications initialized.");
  }

  Future<void> showNotification(
      String title, String body, int notificationId) async {
    print("Showing notification: $title, $body");

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidNotificationDetails);

    notificationsList.add('$title: $body');

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
    print("Notification displayed: $title");
  }

  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    print("Fetching notifications from API...");
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/api/V1/notifications'));

      if (response.statusCode == 200) {
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

  Future<void> loadNotificationsList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedNotifications = prefs.getStringList('notificationsList');

    if (savedNotifications != null) {
      notificationsList = savedNotifications;
    }
  }

  Future<void> saveNotificationsList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notificationsList', notificationsList);
  }

  void startNotificationTimer() {
    print("Starting notification timer...");
    Timer.periodic(Duration(minutes: 10), (timer) async {
      print("Timer triggered, fetching notifications...");
      List<Map<String, dynamic>> notifications = await fetchNotifications();

      for (var notification in notifications) {
        if (notification['isRead'] == 0) {
          String notificationMessage = notification['message'];
          int notificationId = notification['id'];

          if (!notificationsList.contains(
              '$notificationMessage: Record ID: ${notification['recordId']}')) {
            showNotification(notificationMessage,
                'Record ID: ${notification['recordId']}', notificationId);
            notificationsList.add(
                '$notificationMessage: Record ID: ${notification['recordId']}');
            saveNotificationsList();
          } else {
            print("Notification already in the list: $notificationMessage");
          }
        }
      }
    });
  }
  int pageController=1;
  
  int total = totalCycles+totalDate+totalHours;
  String item1 = 'A380';
  String item2 = 'A350';
  String item3 = 'A330';
  
  var black = Colors.grey.shade900;
  var white = Colors.white;
  var  grey= Colors.grey.shade800;
  String bell = 'assets/system-regular-46-notification-bell (1).json';
  String exit = 'assets/wired-outline-1725-exit-sign (2).json';
  bool isDarkModeEnabled = true;
  darkmode (){
    if (isDarkModeEnabled){
      black = Colors.grey.shade900;
      white = Colors.white;
      grey = Colors.grey.shade800;
      bell = 'assets/system-regular-46-notification-bell (1).json';
      exit = 'assets/wired-outline-1725-exit-sign (2).json';
    }else{
      black = Colors.grey.shade300;
      white = Colors.black;
      grey = Colors.grey.shade100;
      bell = 'assets/system-regular-46-notification-bell.json';
      exit = 'assets/wired-outline-1725-exit-sign.json';
    }
  }
  Widget body1(){
    if(pageController == 0){
      return Container(
        color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
        child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          Container(
          margin: const EdgeInsets.all(20),
          //padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: isDarkModeEnabled ? const Color(0x89000000) : const Color.fromRGBO(158, 158, 158, 1),
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0
                ),
                BoxShadow (
                  color: isDarkModeEnabled ? const Color.fromRGBO(66, 66, 66, 1) : const Color.fromRGBO(255, 255, 255, 1),
                  offset: const Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0
                ),
              ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "critical componenets on $titleMain",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.airplane_ticket_outlined, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                    Text(
                      titleMain == 'A380'
                          ? "Hour Componenets: $rowCountHC"
                          : titleMain == 'A350'
                              ? "Hour Componenets: $rowCountHA"
                              : titleMain == 'A330'
                                  ? "Hour Componenets: $rowCountHB"
                                  : "hello",
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.access_time, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                    Text(
                      titleMain == 'A380'
                          ? "Cycle Componenets: $rowCountCC"
                          : titleMain == 'A350'
                              ? "Cycle Componenets: $rowCountCA"
                              : titleMain == 'A330'
                                  ? "Cycle  Componenets: $rowCountCB"
                                  : "hello",
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.date_range, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                    Text(
                      titleMain == 'A380'
                          ? "Date Componenets: $rowCountDC"
                          : titleMain == 'A350'
                              ? "Date Componenets: $rowCountDA"
                              : titleMain == 'A330'
                                  ? "Date Componenets: $rowCountDB"
                                  : "hello",
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),                  
          ),
          // Conditionally display widgets based on titleMain
          if (titleMain == 'A380') ...[
            HC(context: context, title: "By Hour", isDarkModeEnabled: isDarkModeEnabled),
            CC(context: context, title: "By Cycle", isDarkModeEnabled: isDarkModeEnabled),
            DC(context: context, title: "By Date", isDarkModeEnabled: isDarkModeEnabled),
          ],
          if (titleMain == 'A350') ...[
            HA(context: context, title: "By Hour", isDarkModeEnabled: isDarkModeEnabled),
            CA(context: context, title: "By Cycle", isDarkModeEnabled: isDarkModeEnabled),
            DA(context: context, title: "By Date", isDarkModeEnabled: isDarkModeEnabled),
          ],
          if (titleMain == 'A330') ...[
            HB(context: context, title: "By Hour", isDarkModeEnabled: isDarkModeEnabled),
            CB(context: context, title: "By Cycle", isDarkModeEnabled: isDarkModeEnabled),
            DB(context: context, title: "By Date", isDarkModeEnabled: isDarkModeEnabled),
          ],
        ],)
    );
    }
    else if (pageController == 1){
      return Container(
        padding: const EdgeInsets.all(10),
        color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
        child: Column(children: [
          Padding (
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text
            (
              "maintenance parts",
              style: GoogleFonts.quicksand(
                textStyle:  TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 50,
            children: [
              Container(
              decoration: BoxDecoration(
                  color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkModeEnabled ? const Color(0x89000000) : const Color.fromRGBO(158, 158, 158, 1),
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0
                    ),
                    BoxShadow (
                      color: isDarkModeEnabled ? const Color.fromRGBO(66, 66, 66, 1) : const Color.fromRGBO(255, 255, 255, 1),
                      offset: const Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text
                    (
                      "$total",
                      style: GoogleFonts.quicksand(
                        textStyle:  TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                        fontSize: 60,
                        fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    Icon(Icons.airplane_ticket, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                        Text
                        (
                          "All Parts ",
                          style: GoogleFonts.quicksand(
                            textStyle:  TextStyle(
                            color: isDarkModeEnabled ? Colors.white : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),                  
              ),
              Container(
              decoration: BoxDecoration(
                  color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkModeEnabled ? const Color(0x89000000) : const Color.fromRGBO(158, 158, 158, 1),
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0
                    ),
                    BoxShadow (
                      color: isDarkModeEnabled ? const Color.fromRGBO(66, 66, 66, 1) : const Color.fromRGBO(255, 255, 255, 1),
                      offset: const Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text
                    (
                      
                      "$totalHours",
                      style: GoogleFonts.quicksand(
                        textStyle:  TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                        fontSize: 60,
                        fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Icon(Icons.access_time, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                        Text
                        (
                          "By Hour",
                          style: GoogleFonts.quicksand(
                            textStyle:  TextStyle(
                            color: isDarkModeEnabled ? Colors.white : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),                  
              ),
              Container(
              decoration: BoxDecoration(
                  color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkModeEnabled ? const Color(0x89000000) : const Color.fromRGBO(158, 158, 158, 1),
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0
                    ),
                    BoxShadow (
                      color: isDarkModeEnabled ? const Color.fromRGBO(66, 66, 66, 1) : const Color.fromRGBO(255, 255, 255, 1),
                      offset: const Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text
                    (
                      "$totalCycles",
                      style: GoogleFonts.quicksand(
                        textStyle:  TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                        fontSize: 60,
                        fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Icon(Icons.airplane_ticket_outlined, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                        Text
                        (
                          "By Cycle",
                          style: GoogleFonts.quicksand(
                            textStyle:  TextStyle(
                            color: isDarkModeEnabled ? Colors.white : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),                  
              ),
              Container(
              decoration: BoxDecoration(
                  color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkModeEnabled ? const Color(0x89000000) : const Color.fromRGBO(158, 158, 158, 1),
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0
                    ),
                    BoxShadow (
                      color: isDarkModeEnabled ? const Color.fromRGBO(66, 66, 66, 1) : const Color.fromRGBO(255, 255, 255, 1),
                      offset: const Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text
                    (
                      "$totalDate",
                      style: GoogleFonts.quicksand(
                        textStyle:  TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                        fontSize: 60,
                        fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Icon(Icons.date_range, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                        Text
                        (
                          "By Date",
                          style: GoogleFonts.quicksand(
                            textStyle:  TextStyle(
                            color: isDarkModeEnabled ? Colors.white : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],),
      );
    }
    else if(pageController==2)//log sheets page start
    {
      return LogSheetWidget(
            key: ValueKey(titleMain),
            isDarkModeEnabled: isDarkModeEnabled,
            nameOfPlane: titleMain, // Pass the current value of titleMain
          );
    }
    else
    {
      return Container();
    }
  }
  Widget appbar1() {
    if (pageController == 0 || pageController == 2) {
      return buildListTileWithPopupMenu(
        isDarkModeEnabled: isDarkModeEnabled,
        title: titleMain,
        item1: 'A380',
        item2: 'A350',
        item3: 'A330',
        onTitleChanged: (newTitle) {
          setState(() {
            titleMain = newTitle;
          });
        },
      );
    } else if (pageController == 1) {
      return DayNightSwitcher(
        isDarkModeEnabled: isDarkModeEnabled,
        onStateChanged: (isDarkModeEnabled) {
          setState(() {
            this.isDarkModeEnabled = isDarkModeEnabled;
          });
        },
      );
    } else {
      return const Text("plane");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch:  Colors.grey,
        backgroundColor: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
      ),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
              leading: IconButton(
                onPressed: () {
                  // Show a dialog with the list of notifications
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // rounded corners for the dialog
                        ),
                        backgroundColor: Colors.transparent, // Transparent background for decoration
                        child: FractionallySizedBox(
                          alignment: Alignment.center,
                          heightFactor: 0.5, // Occupy 50% of the screen height
                          child: Container(
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
                            child: Padding(
                              padding: const EdgeInsets.all(16.0), // Add padding around the content
                              child: StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min, // Make column take only as much space as needed
                                      mainAxisAlignment: MainAxisAlignment.center, // Vertically center the content
                                      children: notificationsList.isEmpty
                                          ? [
                                              Center(
                                                child: Text(
                                                  'No notifications available.',
                                                  style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(
                                                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                                                      fontSize: 20, // Updated to 20
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]
                                          : notificationsList.map((notification) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: isDarkModeEnabled ? Colors.grey[850] : Colors.white,
                                                  borderRadius: BorderRadius.circular(10), // rounded corners for each notification
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: isDarkModeEnabled
                                                          ? const Color(0x89000000)
                                                          : const Color.fromRGBO(158, 158, 158, 1),
                                                      offset: const Offset(4.0, 4.0),
                                                      blurRadius: 8.0,
                                                      spreadRadius: 1.0,
                                                    ),
                                                    BoxShadow(
                                                      color: isDarkModeEnabled
                                                          ? const Color.fromRGBO(66, 66, 66, 1)
                                                          : const Color.fromRGBO(255, 255, 255, 1),
                                                      offset: const Offset(-4.0, -4.0),
                                                      blurRadius: 8.0,
                                                      spreadRadius: 1.0,
                                                    ),
                                                  ],
                                                ),
                                                margin: const EdgeInsets.symmetric(vertical: 8.0), // margin between notifications
                                                child: ListTile(
                                                  title: Text(
                                                    notification,
                                                    style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(
                                                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                                                        fontSize: 20, // Same font size and style as the 'No notifications available' text
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  trailing: IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        notificationsList.remove(notification);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      isDarkModeEnabled ? Colors.white : Colors.black,  // Change the color based on dark mode
                      BlendMode.srcIn, // Apply the color to the Lottie icon
                    ),
                    child: Lottie.asset(bell),
                  ),
              ),


              title: appbar1(),
              actions: [
                IconButton(
                  onPressed: (() {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => const LogInPage())));
                  }),
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      isDarkModeEnabled ? Colors.white : Colors.black,  // Change the color based on dark mode
                      BlendMode.srcIn, // Apply the color to the Lottie icon
                    ),
                    child: Lottie.asset(exit),
                  ),

                ),
              ]
            ),
          ],
          body:
          body1()
          
        ),
        bottomNavigationBar: Container(
          color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],  // Background color based on dark mode
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: GNav(
              onTabChange: (value) {
                setState(() {
                  pageController = value;
                });
              },
              selectedIndex: 1,
              gap: 15,
              backgroundColor: isDarkModeEnabled ? Colors.grey[900]! : Colors.grey[300]!,  // Background of the navbar based on dark mode
              color: isDarkModeEnabled ? Colors.white : Colors.black,  // Icon color when not selected
              activeColor: isDarkModeEnabled ? Colors.white : Colors.black,  // Icon color when selected
              tabBackgroundColor: isDarkModeEnabled ? Colors.grey[700]! : Colors.grey[200]!,  // Background color of the tab when selected
              padding: const EdgeInsets.all(15),
              tabs: const [
                GButton(
                  icon: LineIcons.tools,
                  text: 'Parts',
                ),
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.paste,
                  text: 'Log-sheets',
                ),
              ]
            ),
          ),
),
      ),
    );
  }
}