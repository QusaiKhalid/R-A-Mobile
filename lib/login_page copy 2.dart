// import 'package:clay_containers/clay_containers.dart';
// import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:qusai_final_project/Controller/db_controller.dart';
// import 'package:qusai_final_project/engineer_page.dart';
// import 'package:qusai_final_project/hidden_drawer.dart';
// import 'package:qusai_final_project/pilot_page%20copy.dart';
// import 'package:qusai_final_project/pilot_page.dart';
// import 'package:qusai_final_project/Model/users.dart';

// class LogInPage extends StatefulWidget {
//   const LogInPage({super.key});

//   @override
//   State<LogInPage> createState() => _LogInPageState();
// }

// class _LogInPageState extends State<LogInPage> {
//   bool isPressed = true;
//   bool isLoading = false;
//   final idController = TextEditingController();
//   final passwordController = TextEditingController();
//   DBcontroller dbc = DBcontroller();
//   final _key = GlobalKey<FormState>();
//   bool isVisisble = true;
//   bool isLoginTrue = false;

//   Future<void> login() async {
//     setState(() {
//       isLoginTrue = false;
//       isLoading = true;
//     });
//     var response = await dbc.login(User.onlyEmail(id: int.parse(idController.text), password: passwordController.text));
//     String? user = await dbc.getUserTypeById(int.parse(idController.text));
    
//     setState(() {
//       isLoading = false;
//     });

//     if (response == true) {
//       if (user == 'Pilot') {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const PilotPage()));
//       } else if (user == 'Engineer') {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const EngineerPage()));
//       } else if (user == 'Admin') {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const HiddenDrawer()));
//       }
//     } else if (response == false) {
//       setState(() {
//         isLoginTrue = true;
//       });
//     }
//   }

//   Future<void> _displayDialoge() async {
//     return showDialog(
//       barrierDismissible: false, 
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.white.withOpacity(0.7),
//           title: const Text(
//             'Contact the admin via 715100828',
//             style: TextStyle(color: Colors.white),
//           ),
//           actions: [
//             OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(width: 2.0, color: Colors.white),
//               ),
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK', style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Offset distance = isPressed ? const Offset(10, 10) : const Offset(15, 15);
//     double blur = isPressed ? 5 : 15;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.only(top: 70),
//           child: Stack(
//             children: [
//               Form(
//                 key: _key,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       "Hello,",
//                       style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 30)),
//                     ),
//                     Text(
//                       "Please enter your credentials.",
//                       style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 20)),
//                     ),
//                     const SizedBox(height: 30),
//                     isLoginTrue
//                         ? const Text("Username or Password is incorrect", style: TextStyle(color: Colors.red))
//                         : const SizedBox(),
//                     const SizedBox(height: 10),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       child: ClayContainer(
//                         emboss: true,
//                         color: const Color.fromARGB(255, 243, 243, 243),
//                         borderRadius: 30,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 30),
//                           child: TextFormField(
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Must enter an E-Mail';
//                               }
//                               // Regex for validating an email address
//                               final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
//                               if (!emailRegex.hasMatch(value)) {
//                                 return 'Enter a valid E-Mail';
//                               }
//                               return null;
//                             },
//                             keyboardType: TextInputType.emailAddress,
//                             controller: idController,
//                             decoration: const InputDecoration(
//                               hintText: "E-Mail",
//                               border: InputBorder.none,
//                               fillColor: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       child: ClayContainer(
//                         emboss: true,
//                         color: const Color.fromARGB(255, 243, 243, 243),
//                         borderRadius: 30,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 30),
//                           child: TextFormField(
//                             validator: (value) {
//                               if (value!.isEmpty) return 'Must enter a password';
//                               return null;
//                             },
//                             keyboardType: TextInputType.text,
//                             controller: passwordController,
//                             obscureText: isVisisble,
//                             decoration: InputDecoration(
//                               suffixIcon: IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     isVisisble = !isVisisble;
//                                   });
//                                 },
//                                 icon: const Icon(Icons.remove_red_eye, color: Color.fromARGB(185, 0, 0, 0)),
//                               ),
//                               hintText: "Password",
//                               border: InputBorder.none,
//                               fillColor: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     TextButton(
//                       onPressed: () {
//                         _displayDialoge();
//                       },
//                       child: Text(
//                         "Forgot your Password?",
//                         style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 15, color: Colors.black)),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     GestureDetector(
//                       onTap: () async {
//                         if (_key.currentState!.validate()) {
//                           await login();
//                           idController.clear();
//                           passwordController.clear();
//                         }
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 100),
//                         width: 120,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           color: const Color.fromARGB(255, 230, 230, 230),
//                           boxShadow: [
//                             BoxShadow(
//                               blurRadius: blur,
//                               offset: distance,
//                               color: Colors.white,
//                               inset: isPressed,
//                             ),
//                             BoxShadow(
//                               blurRadius: blur,
//                               offset: distance,
//                               color: const Color.fromARGB(179, 146, 146, 146),
//                               inset: isPressed,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: isLoading
//                               ? const CircularProgressIndicator()
//                               : const Text('Log-IN'),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Lottie.asset('assets/p2.json'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
