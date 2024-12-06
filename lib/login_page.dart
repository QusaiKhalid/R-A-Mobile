import 'dart:convert';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:qusai_final_project/engineer_page.dart';
import 'package:qusai_final_project/hidden_drawer.dart';
import 'package:qusai_final_project/pilot_page.dart';

const String baseUrl = 'http://10.0.2.2:8000/api/V1'; // Replace with your backend URL
const String loginEndpoint = '$baseUrl/login';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isPressed = true;
  bool isLoading = false;
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool isVisisble = true;
  bool isLoginTrue = false;

  // Variable to store the user role
  int? userRole;

  Future<bool> login(String email, String password) async {
    final url = Uri.parse(loginEndpoint);

    try {
      // Debugging the request
      debugPrint('Attempting to log in...');
      debugPrint('POST URL: $url');
      debugPrint('Headers: ${{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }}');
      debugPrint('Body: ${jsonEncode({'email': email, 'password': password})}');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      // Debugging the response
      debugPrint('Response Status: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('Login Success: $data');

        // Save the user role from the response
        userRole = data['user']['role']; // Extracting the role from the response
        return true;
      } else {
        debugPrint('Login Failed: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error during login: $e');
      return false;
    }
  }

  Future<void> _performLogin() async {
    if (!_key.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      isLoginTrue = false;
    });

    final email = idController.text;
    final password = passwordController.text;

    final success = await login(email, password);

    setState(() {
      isLoading = false;
      isLoginTrue = !success;
    });

    if (success) {
      // Navigate to role-specific pages based on the role
      if (userRole == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PilotPage()));
      } else if (userRole == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const EngineerPage()));
      } else if (userRole == 3) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HiddenDrawer()));
      } else {
        // Handle unknown role
        debugPrint("Unknown role: $userRole");
      }
    }
  }

  Future<void> _displayDialog() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.7),
          title: const Text(
            'Contact the admin via 715100828',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 2.0, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed ? const Offset(10, 10) : const Offset(15, 15);
    double blur = isPressed ? 5 : 15;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 70),
          child: Stack(
            children: [
              Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Hello,",
                      style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 30)),
                    ),
                    Text(
                      "Please enter your credentials.",
                      style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(height: 30),
                    isLoginTrue
                        ? const Text("Invalid E-Mail or Password", style: TextStyle(color: Colors.red))
                        : const SizedBox(),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ClayContainer(
                        emboss: true,
                        color: const Color.fromARGB(255, 243, 243, 243),
                        borderRadius: 30,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your E-Mail';
                              }
                              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Enter a valid E-Mail';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: idController,
                            decoration: const InputDecoration(
                              hintText: "E-Mail",
                              border: InputBorder.none,
                              fillColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ClayContainer(
                        emboss: true,
                        color: const Color.fromARGB(255, 243, 243, 243),
                        borderRadius: 30,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your Password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            obscureText: isVisisble,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisisble = !isVisisble;
                                  });
                                },
                                icon: const Icon(Icons.remove_red_eye, color: Color.fromARGB(185, 0, 0, 0)),
                              ),
                              hintText: "Password",
                              border: InputBorder.none,
                              fillColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        _displayDialog();
                      },
                      child: Text(
                        "Forgot your Password?",
                        style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        await _performLogin();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(255, 230, 230, 230),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: blur,
                              offset: distance,
                              color: Colors.white,
                              inset: isPressed,
                            ),
                            BoxShadow(
                              blurRadius: blur,
                              offset: distance,
                              color: const Color.fromARGB(179, 146, 146, 146),
                              inset: isPressed,
                            ),
                          ],
                        ),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Log-IN'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Lottie.asset('assets/p2.json'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
