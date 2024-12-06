import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:qusai_final_project/login_page.dart';

import 'engineer_app_bar_1.dart';
import 'api_servise_log_sheet.dart';
import 'test.dart';

class EngineerPage extends StatefulWidget {
  const EngineerPage({super.key});

  @override
  State<EngineerPage> createState() => _EngineerPageState();
}

class _EngineerPageState extends State<EngineerPage> with SingleTickerProviderStateMixin{
  int pageController=1;
  String title = 'A380';
  String item1 = 'A380';
  String item2 = 'A350';
  String item3 = 'A330';
  String item4 = 'A320';
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
                  "Stats of $title",
                  style: GoogleFonts.quicksand(
                    textStyle:  TextStyle(
                    color: isDarkModeEnabled ? Colors.white : Colors.black,
                    fontSize: 40,
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
                      "Landings: 707",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.access_time, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                    Text
                    (
                      "hours: 8877",
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
          margin: const EdgeInsets.all(20),
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text
                  (
                    
                    "Next part by hours: ",
                    style: GoogleFonts.quicksand(
                      textStyle:  TextStyle(
                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text
                  (
                    "bypass ducts",
                    style: GoogleFonts.quicksand(
                      textStyle:  TextStyle(
                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.access_time, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                    Text(
                      "At 9000 Hours",
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
          margin: const EdgeInsets.all(20),
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text
                  (
                    "Next part by landings: ",
                    style: GoogleFonts.quicksand(
                      textStyle:  TextStyle(
                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text
                  (
                    "Compressors",
                    style: GoogleFonts.quicksand(
                      textStyle:  TextStyle(
                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.airplane_ticket_outlined, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                    Text(
                      "At 777 Landings",
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
        ],)
    );
    }
    else if (pageController == 1){
      return Container(
        padding: const EdgeInsets.all(10),
        color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
        child: Column(children: [
          Padding (
            padding: const EdgeInsets.only(top: 20),
            child: Text
            (
              "maintenance parts",
              style: GoogleFonts.quicksand(
                textStyle:  TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
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
                      "2",
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
                        Icon(Icons.crisis_alert, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                        Text
                        (
                          "Past Due",
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
                      "12",
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
                        Icon(Icons.access_alarm, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                        Text
                        (
                          "Comming Due",
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
                      "7",
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
                        Icon(Icons.access_alarm, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
                        Text
                        (
                          "Comming Due",
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
      return Container
      (
        color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
        child: GridView.count
        (
          shrinkWrap: true,
          crossAxisCount: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: 
          [
            buildLogSheet
            (
              flightNumber: "YA721",
              captain: "Qusai Almansour",
              duration: "7 Hours 47 Minutes",
              from: "SIA",
              to: "DXB",
              isDarkModeEnabled: isDarkModeEnabled,
            ),
            buildLogSheet
            (
              flightNumber: "YA721",
              captain: "Qusai Almansour",
              duration: "7 Hours 47 Minutes",
              from: "SIA",
              to: "DXB",
              isDarkModeEnabled: isDarkModeEnabled,
            ),
          ],
        ),
      );
    }
    else
    {
      return Container();
    }
  }
  Widget appbar1(){

      if(pageController == 0)
      {
        return buildListTileWithPopupMenu
        (
          title: title,
          item1: 'A380',
          item2: 'A330',
          item3: 'A320',
          onTitleChanged: (newTitle) {
            setState(() {
              title = newTitle;
            });
          },
        );
      }
      else if (pageController == 1)
      {
        return DayNightSwitcher(
          // nightBackgroundColor: Colors.black,
          // dayBackgroundColor: Colors.white,
          isDarkModeEnabled: isDarkModeEnabled,
          onStateChanged: (isDarkModeEnabled) {
            setState(() {
              this.isDarkModeEnabled = isDarkModeEnabled;
              darkmode();
            });
          },
        );
      }
      else if (pageController == 2)
      {
        return buildListTileWithPopupMenu
        (
          title: title,
          item1: 'A380',
          item2: 'A330',
          item3: 'A320',
          onTitleChanged: (newTitle) {
            setState(() {
              title = newTitle;
            });
          },
        );
      }
      else
      { return const Text("plane"); }
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
              backgroundColor: black,
              leading: IconButton(
                onPressed:null,
                icon: Lottie.asset(bell),
              ),
              title: appbar1(),
              actions: [
                IconButton(
                  onPressed: (() {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => const LogInPage())));
                  }),
                  icon: Lottie.asset(exit),
                ),
              ]
            ),
          ],
          body:
          body1()
          
        ),
        bottomNavigationBar: Container(
          color: black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0, vertical: 10.0),
            child: GNav(
              onTabChange: (value) {
                setState(() {
                  pageController = value;
                });
                
              },
              selectedIndex: 1,
              gap: 15,
              backgroundColor: black,
              color: white,
              activeColor: white,
              tabBackgroundColor: grey,
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
                // GButton(
                //   icon: LineIcons.cog,
                //   text: 'settings',
                // )
              ]
            ),
          ),
        ),
      ),
    );
  }
}