// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:qusai_final_project/glass_box.dart';
// import 'package:qusai_final_project/login_page.dart';

// class PilotPage extends StatefulWidget {
//   const PilotPage({super.key});

//   @override
//   State<PilotPage> createState() => _PilotPageState();
// }

// class _PilotPageState extends State<PilotPage> {
//   String planeDropDownValeu = "A380";
//   String airpotsDropDownValeu = "SAH";
//   DateTime departureDatetime = DateTime.now();
//   DateTime arivalDatetime = DateTime.now();
//   final _key = GlobalKey<FormState>();

//   Future<void> _displayDialoge() {
//     return showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: ((context) {
//         return AlertDialog(
//           backgroundColor: Colors.white.withOpacity(0.7),
//           title: const Text(
//             'Are you sure!',
//             style: TextStyle(color: Colors.white),
//           ),
//           actions: [
//             OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(width: 2.0, color: Colors.white),
//               ),
//               onPressed: (() => Navigator.pop(context)),
//               child: const Text('Cancel', style: TextStyle(color: Colors.white)),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: ((context) => const LogInPage())),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(1, 1, 1, 1)),
//               child: const Text(
//                 'Add',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   // Method to send the form data to the API
//   Future<void> submitForm() async {
//     if (!_key.currentState!.validate()) return; // Validate the form

//     // Prepare the data to send
//     final Map<String, dynamic> formData = {
//       'name_of_plane': planeDropDownValeu,
//       'no_of_flight': 123, // Replace with actual flight number input field
//       'start_date': departureDatetime.toIso8601String(),
//       'end_date': arivalDatetime.toIso8601String(),
//       'take_off_time': departureDatetime.toIso8601String(), // You can format this as required
//       'landing_time': arivalDatetime.toIso8601String(), // Format as required
//       'departure': airpotsDropDownValeu,
//       'arrival': airpotsDropDownValeu,
//     };

//     const String apiUrl = 'https://10.0.2.2/api/V1/logsheet'; // Replace with your API URL

//     try {
//       // Send data to the API
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode(formData),
//       );

//       if (response.statusCode == 201) {
//         // Handle success
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('LogSheet added successfully')),
//         );
//       } else {
//         // Handle failure
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to add LogSheet')),
//         );
//       }
//     } catch (error) {
//       // Handle error
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $error')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("assets/peakpx.jpg"), fit: BoxFit.fill)),
//           alignment: const Alignment(0, 0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.fromLTRB(40, 40, 40, 0),
//                   child: GlassBox(
//                     width: double.infinity,
//                     height: 40.0,
//                     child: Center(
//                       child: TextButton(
//                         onPressed: (() {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: ((context) => const LogInPage())),
//                           );
//                         }),
//                         child: Text(
//                           'Sign-out',
//                           style: GoogleFonts.quicksand(
//                               textStyle: const TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                           )),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.all(40),
//                   child: GlassBox(
//                     width: double.infinity,
//                     height: 666.0,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Form(
//                         key: _key,
//                         child: Column(
//                           children: [
//                             // Form Fields...
//                             TextFormField(
//                               validator: (value) {
//                                 if (value!.isEmpty) return 'Must enter a name';
//                                 return null;
//                               },
//                               style: const TextStyle(color: Colors.white),
//                               decoration: const InputDecoration(
//                                 labelText: 'Captain name',
//                                 labelStyle: TextStyle(color: Colors.white),
//                                 prefixIcon: Icon(
//                                   Icons.person_outlined,
//                                   color: Colors.white,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                             // Other form fields go here...

//                             const SizedBox(height: 10),

//                             Text(
//                               "Departure info:",
//                               style: GoogleFonts.quicksand(
//                                   textStyle: const TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               )),
//                             ),
//                             const SizedBox(height: 10),

//                             // Departure DateTime picker
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   '${departureDatetime.day}/${departureDatetime.month}/${departureDatetime.year} - ${departureDatetime.hour}:${departureDatetime.minute}',
//                                   style: GoogleFonts.quicksand(
//                                       textStyle: const TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                   )),
//                                 ),
//                                 IconButton(
//                                   onPressed: (() async {
//                                     DateTime? newDate = await showDatePicker(
//                                         context: context,
//                                         initialDate: departureDatetime,
//                                         firstDate: DateTime(2020),
//                                         lastDate: DateTime(2200));
//                                     if (newDate == null) return;

//                                     TimeOfDay? newTime = await showTimePicker(
//                                         context: context,
//                                         initialTime: TimeOfDay(
//                                             hour: departureDatetime.hour,
//                                             minute: departureDatetime.minute));

//                                     if (newTime == null) return;

//                                     final newDateTime = DateTime(
//                                       newDate.year,
//                                       newDate.month,
//                                       newDate.day,
//                                       newTime.hour,
//                                       newTime.minute,
//                                     );

//                                     setState(() {
//                                       departureDatetime = newDateTime;
//                                     });
//                                   }),
//                                   icon: const Icon(
//                                     Icons.alarm,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               "Arrival information:",
//                               style: GoogleFonts.quicksand(
//                                   textStyle: const TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               )),
//                             ),
//                             const SizedBox(height: 10),

//                             // Arrival DateTime picker
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   '${arivalDatetime.day}/${arivalDatetime.month}/${arivalDatetime.year} - ${arivalDatetime.hour}:${arivalDatetime.minute}',
//                                   style: GoogleFonts.quicksand(
//                                       textStyle: const TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                   )),
//                                 ),
//                                 IconButton(
//                                   onPressed: (() async {
//                                     DateTime? newDate = await showDatePicker(
//                                         context: context,
//                                         initialDate: arivalDatetime,
//                                         firstDate: DateTime(2020),
//                                         lastDate: DateTime(2200));
//                                     if (newDate == null) return;

//                                     TimeOfDay? newTime = await showTimePicker(
//                                         context: context,
//                                         initialTime: TimeOfDay(
//                                             hour: arivalDatetime.hour,
//                                             minute: arivalDatetime.minute));

//                                     if (newTime == null) return;

//                                     final newDateTime = DateTime(
//                                       newDate.year,
//                                       newDate.month,
//                                       newDate.day,
//                                       newTime.hour,
//                                       newTime.minute,
//                                     );

//                                     setState(() {
//                                       arivalDatetime = newDateTime;
//                                     });
//                                   }),
//                                   icon: const Icon(
//                                     Icons.alarm,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.transparent,
//                                 onPrimary: Colors.white,
//                               ),
//                               onPressed: submitForm,
//                               child: const Text(
//                                 'Submit LogSheet',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
