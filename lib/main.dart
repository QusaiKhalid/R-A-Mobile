import 'package:flutter/material.dart';
import 'package:qusai_final_project/add_user.dart';
import 'package:qusai_final_project/engineer_page.dart';
import 'package:qusai_final_project/login_page.dart';
import 'package:qusai_final_project/onboarding_screen.dart';
import 'package:qusai_final_project/parts_page.dart';
import 'package:qusai_final_project/pilot_page.dart';
import 'package:qusai_final_project/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: OnBoardingScreen(),
    );
  }
}
