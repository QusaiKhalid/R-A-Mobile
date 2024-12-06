import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:qusai_final_project/login_page.dart';

class Parts extends StatefulWidget {
  const Parts({super.key});

  @override
  State<Parts> createState() => _PartsState();
}

class _PartsState extends State<Parts> with SingleTickerProviderStateMixin{
  
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
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch:  Colors.grey),
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
              actions: [
              
                DayNightSwitcher(
                  // nightBackgroundColor: Colors.black,
                  // dayBackgroundColor: Colors.white,
                  isDarkModeEnabled: isDarkModeEnabled,
                  onStateChanged: (isDarkModeEnabled) {
                    setState(() {
                      this.isDarkModeEnabled = isDarkModeEnabled;
                      darkmode();
                    });
                  },
                ),
                const SizedBox(width: 55,),
                IconButton(
                  onPressed: (() {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => const LogInPage())));
                  }),
                  icon: Lottie.asset(exit),
                ),
              ]
            ),
          ],
          body: Container()
        ),
        bottomNavigationBar: Container(
          color: black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0, vertical: 10.0),
            child: GNav(
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