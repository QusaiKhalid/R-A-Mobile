class LogSheet {
  final int id;
  final String nameOfPlane;
  final String noOfFlight;
  final String startDate;  // Fixed typo here
  final String endDate;
  final String takeOffTime;  // Fixed typo here
  final String landingTime;
  final String departure;  // Fixed typo here
  final String arrival;

  LogSheet({
    required this.id,
    required this.nameOfPlane,
    required this.noOfFlight,
    required this.startDate,  // Fixed typo here
    required this.endDate,
    required this.takeOffTime,  // Fixed typo here
    required this.landingTime,
    required this.departure,  // Fixed typo here
    required this.arrival,
  });

  // Factory method to create a LogSheet from JSON
  factory LogSheet.fromJson(Map<String, dynamic> json) {
    return LogSheet(
      id: json['id'],
      nameOfPlane: json['nameOfPlane'],
      noOfFlight: json['noOfFlight'],
      startDate: json['startDate'],  // Fixed typo here
      endDate: json['endDate'],
      takeOffTime: json['takeOffTime'],  // Fixed typo here
      landingTime: json['landingTime'],
      departure: json['departure'],  // Fixed typo here
      arrival: json['arrival'],
    );
  }

  // Method to convert LogSheet to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameOfPlane': nameOfPlane,
      'noOfFlight': noOfFlight,
      'startDate': startDate,  // Fixed typo here
      'endDate': endDate,
      'takeOffTime': takeOffTime,  // Fixed typo here
      'landingTime': landingTime,
      'departure': departure,  // Fixed typo here
      'arrival': arrival,
    };
  }
}
