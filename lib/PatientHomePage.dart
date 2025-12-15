import 'package:flutter/material.dart';
import 'patientdetailpage.dart';

class PatientHomePage extends StatelessWidget {
  const PatientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste fictive de patients
    final List<Map<String, dynamic>> patients = [
      {
        "firstName": "Aya",
        "lastName": "Boudnani",
        "age": 28,
        "maladie": "Hypertension",
        "phone": "+212600000001",
        "email": "aya@example.com",
        "severity": 3,
        "durationDays": 10,
        "hospitalizationsLastYear": 1,
        "functionalScore": 85,
        "bmi": 22.5,
        "symptomsDescription": "Maux de tête et fatigue.",
      },
      {
        "firstName": "Khalid",
        "lastName": "El Amrani",
        "age": 45,
        "maladie": "Diabète",
        "phone": "+212600000002",
        "email": "khalid@example.com",
        "severity": 2,
        "durationDays": 5,
        "hospitalizationsLastYear": 0,
        "functionalScore": 90,
        "bmi": 27.0,
        "symptomsDescription": "Fatigue et soif excessive.",
      },
      {
        "firstName": "Fatima",
        "lastName": "Zahra",
        "age": 33,
        "maladie": "Asthme",
        "phone": "+212600000003",
        "email": "fatima@example.com",
        "severity": 4,
        "durationDays": 15,
        "hospitalizationsLastYear": 2,
        "functionalScore": 70,
        "bmi": 24.3,
        "symptomsDescription": "Essoufflement et toux.",
      },
      {
        "firstName": "Youssef",
        "lastName": "Chakib",
        "age": 52,
        "maladie": "Cardiopathie",
        "phone": "+212600000004",
        "email": "youssef@example.com",
        "severity": 5,
        "durationDays": 20,
        "hospitalizationsLastYear": 3,
        "functionalScore": 60,
        "bmi": 28.7,
        "symptomsDescription": "Douleur thoracique et fatigue.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes patients"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: patients.length,
          itemBuilder: (context, index) {
            final patient = patients[index];

            return Card(
              color: const Color.fromARGB(
                255,
                128,
                189,
                217,
              ), // toutes les cartes bleues
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: Text(
                  "${patient['firstName']} ${patient['lastName']}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${patient['maladie']} • ${patient['age']} ans",
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientDetailPage(patient: patient),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
