import 'package:flutter/material.dart';

class ConsultationsPage extends StatelessWidget {
  const ConsultationsPage({super.key});

  static const Color primaryColor = Color(0xFF2CC295);
  static const Color backgroundColor = Color(0xFFF6F9F8);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> consultations = [
      {
        "patient": "Aya Boudnani",
        "date": "14 Décembre 2025",
        "time": "10:00",
        "type": "Consultation générale",
        "status": "Confirmé",
      },
      {
        "patient": "Khalid El Amrani",
        "date": "15 Décembre 2025",
        "time": "14:30",
        "type": "Suivi diabète",
        "status": "Confirmé",
      },
      {
        "patient": "Fatima Zahra",
        "date": "16 Décembre 2025",
        "time": "09:00",
        "type": "Asthme",
        "status": "Annulé",
      },
      {
        "patient": "Youssef Chakib",
        "date": "17 Décembre 2025",
        "time": "11:00",
        "type": "Cardiologie",
        "status": "Confirmé",
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Rendez-vous",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: consultations.length,
          itemBuilder: (context, index) {
            final consultation = consultations[index];

            final bool isConfirmed = consultation['status'] == "Confirmé";

            final Color statusColor = isConfirmed
                ? primaryColor
                : const Color(0xFFEF4444);

            return Card(
              elevation: 4,
              shadowColor: primaryColor.withOpacity(0.15),
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.medical_services,
                    color: primaryColor,
                  ),
                ),
                title: Text(
                  consultation['patient']!,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "${consultation['type']} • ${consultation['date']} • ${consultation['time']}",
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                    ),
                  ),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    consultation['status']!,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                onTap: () {
                  // Navigation vers les détails du rendez-vous
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
