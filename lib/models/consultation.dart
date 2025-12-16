import 'patient.dart';

class Consultation {
  final int id;
  final String date;
  final String time;
  final String status;
  final Patient? patient;

  Consultation({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    this.patient,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      id: json['id'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      patient: json['patient'] != null
          ? Patient.fromJson(json['patient'])
          : null,
    );
  }
}
