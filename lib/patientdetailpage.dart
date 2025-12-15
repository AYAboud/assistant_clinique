import 'package:flutter/material.dart';

class PatientDetailPage extends StatelessWidget {
  final Map<String, dynamic> patient;

  const PatientDetailPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${patient['firstName']} ${patient['lastName']}"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar du patient
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal.shade200,
              child: Text(
                "${patient['firstName'][0]}${patient['lastName'][0]}",
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Carte principale informations générales
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              color: Colors.lightBlue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      "Nom",
                      "${patient['firstName']} ${patient['lastName']}",
                    ),
                    _buildInfoRow("Âge", "${patient['age']} ans"),
                    _buildInfoRow("Maladie", patient['maladie']),
                    _buildInfoRow("Téléphone", patient['phone']),
                    _buildInfoRow("Email", patient['email']),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Carte informations médicales
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              color: Colors.teal.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Informations médicales",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow("Sévérité", "${patient['severity']} / 5"),
                    _buildInfoRow(
                      "Durée symptômes",
                      "${patient['durationDays']} jours",
                    ),
                    _buildInfoRow(
                      "Hospitalisations l'an dernier",
                      "${patient['hospitalizationsLastYear']}",
                    ),
                    _buildInfoRow(
                      "Score fonctionnel",
                      "${patient['functionalScore']} / 100",
                    ),
                    _buildInfoRow("IMC", "${patient['bmi']}"),
                    _buildInfoRow("Symptômes", patient['symptomsDescription']),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher un label et sa valeur
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
