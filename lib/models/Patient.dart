class Patient {
  final int id;
  final String firstName;
  final String lastName;

  Patient({required this.id, required this.firstName, required this.lastName});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
