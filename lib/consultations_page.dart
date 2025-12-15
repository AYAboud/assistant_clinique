import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/consultation.dart';

class ConsultationsPage extends StatefulWidget {
  const ConsultationsPage({super.key});

  @override
  ConsultationsPageState createState() => ConsultationsPageState();
}

class ConsultationsPageState extends State<ConsultationsPage> {
  List<Consultation> consultations = [];
  bool isLoading = true;

  static const Color primaryColor = Color(0xFF2CC295);
  static const Color backgroundColor = Color(0xFFF6F9F8);

  @override
  void initState() {
    super.initState();
    fetchConsultations();
  }

  Future<void> fetchConsultations() async {
    try {
      final url = Uri.parse('http://10.14.46.2:8082/consultations/doctor/1');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          consultations = data
              .map((json) => Consultation.fromJson(json))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Color withOpacitySafe(Color color, double opacity) =>
      Color.fromRGBO(color.red, color.green, color.blue, opacity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Rendez-vous",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 2,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: consultations.length,
                itemBuilder: (context, index) {
                  final consultation = consultations[index];
                  final bool isConfirmed =
                      consultation.status == "PLANNED" ||
                      consultation.status == "DONE";
                  final Color statusColor = isConfirmed
                      ? primaryColor
                      : const Color(0xFFEF4444);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              withOpacitySafe(Colors.grey.shade100, 1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundColor: withOpacitySafe(primaryColor, 0.2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.asset(
                                'assets/doctor.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.medical_services,
                                    color: primaryColor,
                                    size: 28,
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Text(
                            "Patient ${consultation.patientId}",
                            style: const TextStyle(
                              color: Color(0xFF1F2937),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              "${consultation.date} • ${consultation.time} • Consultation",
                              style: const TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: withOpacitySafe(statusColor, 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              consultation.status,
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
