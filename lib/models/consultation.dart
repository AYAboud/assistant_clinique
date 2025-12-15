class Consultation {
  final int id;
  final int doctorId;
  final int patientId;
  final String date;
  final String time;
  final String status;

  Consultation({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      id: json['id'],
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }
}
