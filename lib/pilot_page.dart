import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qusai_final_project/api_servise_log_sheet.dart';
import 'package:qusai_final_project/glass_box.dart';
import 'package:qusai_final_project/login_page.dart';

class PilotPage extends StatefulWidget {
  const PilotPage({super.key});

  @override
  State<PilotPage> createState() => _PilotPageState();
}

class _PilotPageState extends State<PilotPage> {
  String planeDropDownValeu = "A380";
  String flightTextValue = "";
  String airpotsDropDownValeuDeparture = "SAH";
  String airpotsDropDownValeuArival = "SAH";
  DateTime departureDatetime = DateTime.now();
  DateTime arivalDatetime = DateTime.now();
  final _key = GlobalKey<FormState>();
  bool isLoading = false;  // Add a loading flag
Future<void> _displayDialoge() {
  return showDialog(
    barrierDismissible: false, // Stops the dialog from dismissing when tapping outside
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.7),
        title: const Text(
          'Are you sure!',
          style: TextStyle(color: Colors.white),
        ),
        content: isLoading
            ? const CircularProgressIndicator()
            : const Text(
                'Click to submit your log sheet.',
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 2.0, color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!_key.currentState!.validate()) return;

              setState(() {
                isLoading = true;
              });

              // Perform your submit function here inside the dialog
              try {
                await submitLogSheet(
                  planeDropDownValeu: planeDropDownValeu,
                  flightTextValue: flightTextValue,
                  airpotsDropDownValeuDeparture: airpotsDropDownValeuDeparture,
                  airpotsDropDownValeuArival: airpotsDropDownValeuArival,
                  departureDatetime: departureDatetime,
                  arivalDatetime: arivalDatetime,
                  context: context,
                );

                // If the submission is successful, close the dialog
                Navigator.pop(context);

                // Show success dialog or additional actions here
                _showSuccessDialog(context);

                // Reset the form and clear all fields after successful submission
                _key.currentState!.reset(); // Reset the form fields

                // Reset all form-related variables to their initial state
                setState(() {
                  planeDropDownValeu = "A380";  // Reset the dropdown value for Plane
                  flightTextValue = '';  // Reset flight text field
                  airpotsDropDownValeuDeparture = "SAH"; // Reset Departure airport dropdown
                  airpotsDropDownValeuArival = "SAH"; // Reset Arrival airport dropdown
                  departureDatetime = DateTime.now();  // Reset departure datetime
                  arivalDatetime = DateTime.now();  // Reset arrival datetime
                });
              } catch (e) {
                setState(() {
                  isLoading = false;
                });
                // Handle any errors that occurred during the submission
                _showErrorDialog(context, e.toString());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(1, 1, 1, 1),
            ),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}


void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Success'),
        content: const Text('Your log sheet has been submitted successfully.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close success dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close error dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/peakpx.jpg"),
                  fit: BoxFit.fill
                )
              ),
              alignment: const Alignment(0, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                      child: GlassBox(
                        width: double.infinity,
                        height: 40.0,
                        child: Center(
                          child: TextButton(
                            onPressed: (() {
                              Navigator.push(context, MaterialPageRoute(builder: ((context) => const LogInPage())));
                            }),
                            child: Text(
                              'Sign-out',
                              style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 20, color: Colors.white)),
                            ),
                          ),
                        )
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(40),
                      child: GlassBox(
                        width: double.infinity,
                        height: 777.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Form(
                            key: _key,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    "Hello Captain!",
                                    style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) return 'Must enter a name';
                                    return null;
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    labelText: 'Captain name',
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon: Icon(Icons.person_outlined, color: Colors.white,),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                TextFormField(
                                  keyboardType: TextInputType.number,  // Restricts the keyboard to number input
                                  validator: (value) {
                                    if (value!.isEmpty) return 'Must enter a flight code';
                                    if (int.tryParse(value) == null) return 'Please enter a valid number';  // Check if the input is a valid number
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      flightTextValue = value; // Update the variable whenever the text changes
                                    });
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    labelText: 'Flight',
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon: Icon(Icons.flight, color: Colors.white),  // Changed icon to more suitable for a flight
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),


                                const SizedBox(height: 20,),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Colors.white.withOpacity(0.2),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    // underline: Container(color: Colors.white, height: 2,),
                                    decoration: const InputDecoration(
                                      labelText: 'Plane',
                                      labelStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    value: planeDropDownValeu,
                                    icon: const Icon(Icons.airplanemode_on_outlined, color: Colors.white,),
                                    style: const TextStyle(color: Colors.white),
                                    items: const [
                                      DropdownMenuItem<String>(
                                        value: "A380",
                                        child: Text("A380"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "A350",
                                        child: Text("A350"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "A330",
                                        child: Text("A330"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "A320",
                                        child: Text("A320"),
                                      ),
                                    ],
                                    onChanged: ((String? newValue) {
                                      setState(() {
                                        planeDropDownValeu = newValue!;
                                      });
                                    })
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  "departure info:",
                                  style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 20, color: Colors.white, )),
                                ),
                                const SizedBox(height: 10,),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Colors.white.withOpacity(0.2),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    // underline: Container(color: Colors.white, height: 2,),
                                    decoration: const InputDecoration(
                                      labelText: 'Airport',
                                      labelStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    value: airpotsDropDownValeuDeparture,
                                    icon: const Icon(Icons.gps_fixed, color: Colors.white,),
                                    style: const TextStyle(color: Colors.white),
                                    items: const [
                                      DropdownMenuItem<String>(
                                        value: "SAH",
                                        child: Text("SAH"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "DXB",
                                        child: Text("DXP"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "AMM",
                                        child: Text("AMM"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "LAX",
                                        child: Text("LAX"),
                                      ),
                                    ],
                                    onChanged: ((String? newValue) {
                                      setState(() {
                                        airpotsDropDownValeuDeparture = newValue!;
                                      });
                                    })
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${departureDatetime.day}/${departureDatetime.month}/${departureDatetime.year} - ${departureDatetime.hour}:${departureDatetime.minute}',
                                      style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 20, color: Colors.white, )),
                                    ),
                                    IconButton(
                                      onPressed: (() async {
                                        DateTime? newDate = await showDatePicker(
                                          context: context,
                                          initialDate: departureDatetime,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2200)
                                        );
                                        if (newDate == null) return;

                                        TimeOfDay? newTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(departureDatetime)
                                        );
                                        if (newTime == null) return;

                                        setState(() {
                                          departureDatetime = DateTime(
                                            newDate.year,
                                            newDate.month,
                                            newDate.day,
                                            newTime.hour,
                                            newTime.minute
                                          );
                                        });
                                      }),
                                      icon: const Icon(Icons.date_range_outlined, color: Colors.white),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Text(
                                  "Arrival info:",
                                  style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 20, color: Colors.white, )),
                                ),
                                const SizedBox(height: 10,),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Colors.white.withOpacity(0.2),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    // underline: Container(color: Colors.white, height: 2,),
                                    decoration: const InputDecoration(
                                      labelText: 'Airport',
                                      labelStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    value: airpotsDropDownValeuArival,
                                    icon: const Icon(Icons.gps_fixed, color: Colors.white,),
                                    style: const TextStyle(color: Colors.white),
                                    items: const [
                                      DropdownMenuItem<String>(
                                        value: "SAH",
                                        child: Text("SAH"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "DXB",
                                        child: Text("DXP"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "AMM",
                                        child: Text("AMM"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "LAX",
                                        child: Text("LAX"),
                                      ),
                                    ],
                                    onChanged: ((String? newValue) {
                                      setState(() {
                                        airpotsDropDownValeuArival = newValue!;
                                      });
                                    })
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${arivalDatetime.day}/${arivalDatetime.month}/${arivalDatetime.year} - ${arivalDatetime.hour}:${arivalDatetime.minute}',
                                      style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 20, color: Colors.white, )),
                                    ),
                                    IconButton(
                                      onPressed: (() async {
                                        DateTime? newDate = await showDatePicker(
                                          context: context,
                                          initialDate: arivalDatetime,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2200)
                                        );
                                        if (newDate == null) return;

                                        TimeOfDay? newTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(arivalDatetime)
                                        );
                                        if (newTime == null) return;

                                        setState(() {
                                          arivalDatetime = DateTime(
                                            newDate.year,
                                            newDate.month,
                                            newDate.day,
                                            newTime.hour,
                                            newTime.minute
                                          );
                                        });
                                      }),
                                      icon: const Icon(Icons.date_range_outlined, color: Colors.white),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(40,0,40,40),
                                  child: GlassBox(
                                      width: double.infinity,
                                      height: 40.0,
                                      child: Center(
                                        child: TextButton(
                                        onPressed: (() {
                                          if (_key.currentState!.validate()) {
                                            // Check if departure and arrival airports are different
                                            if (airpotsDropDownValeuDeparture == airpotsDropDownValeuArival) {
                                              // Show a dialog or snackbar indicating the error
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Departure and Arrival airports must be different!',
                                                    style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 16, color: Colors.white)),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            } else {
                                              // Check if the time difference between arrival and departure is more than 18 hours
                                              Duration difference = arivalDatetime.difference(departureDatetime);
                                              
                                              // Check if the difference is more than 18 hours or if the times are the same (i.e., 0 hours difference)
                                              if (difference.inHours > 18) {
                                                // Show a dialog or snackbar indicating the error
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'The difference between arrival and departure cannot be more than 18 hours!',
                                                      style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 16, color: Colors.white)),
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } else if (difference.isNegative || difference.inHours == 0) {
                                                // Check if the arrival time is earlier than the departure time or the same
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Arrival time cannot be the same or earlier than the departure time!',
                                                      style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 16, color: Colors.white)),
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } else {
                                                _displayDialoge(); // Proceed with form submission if all checks pass
                                              }
                                            }
                                          }
                                        }),
                                        child: Text(
                                          'Submit',
                                          style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 20, color: Colors.white)),
                                        ),
                                      )
                                    )
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
