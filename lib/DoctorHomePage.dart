import 'package:flutter/material.dart';
import 'PatientHomePage.dart';
import 'consultations_page.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text(
          "Dashboard Docteur",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------- MINI CALENDRIER --------------------
            const Text(
              "Calendrier",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _miniCalendar(),

            const SizedBox(height: 30),

            // --------------------- STATISTIQUES ------------------------
            const Text(
              "Statistiques hebdomadaires",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DRAWER / SIDE BAR
  // ---------------------------------------------------------------------------

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.teal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage("assets/doctor.jpg"),
                ),
                SizedBox(height: 10),
                Text(
                  "Dr. Ahmed Salmi",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  "Cardiologue",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // -------------------- AJOUT : PROFILE --------------------
          ListTile(
            leading: const Icon(Icons.person, color: Colors.deepPurple),
            title: const Text("Profil"),
            onTap: () {
              Navigator.pushNamed(context, "/doctorProfile");
            },
          ),

          // Planning
          ListTile(
            leading: const Icon(Icons.calendar_month, color: Colors.teal),
            title: const Text("Mon planning"),
            onTap: () {
              Navigator.pushNamed(context, "/doctorSchedule");
            },
          ),

          // Patients
          ListTile(
            leading: const Icon(Icons.person_search, color: Colors.blue),
            title: const Text("Mes patients"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PatientHomePage(),
                ),
              );
            },
          ),

          // -------------------- AJOUT : CONSULTATIONS --------------------
          ListTile(
            leading: const Icon(
              Icons.medical_services,
              color: Colors.redAccent,
            ),
            title: const Text("Rendez-vous"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConsultationsPage(),
                ),
              );
            },
          ),

          // Historiques
          ListTile(
            leading: const Icon(Icons.history, color: Colors.orange),
            title: const Text("Historiques"),
            onTap: () {},
          ),

          const Spacer(),

          // Déconnexion
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Déconnexion"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // MINI CALENDRIER
  // ---------------------------------------------------------------------------
  Widget _miniCalendar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [
          const Text(
            "Janvier 2025",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _day("Lun"),
              _day("Mar"),
              _day("Mer"),
              _day("Jeu"),
              _day("Ven"),
              _day("Sam"),
              _day("Dim"),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(30, (i) {
              return Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (i + 1) == 12 ? Colors.white : Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "${i + 1}",
                  style: TextStyle(
                    color: (i + 1) == 12 ? Colors.teal : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _day(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  // ---------------------------------------------------------------------------
  // GRAPHIQUE DE STATISTIQUES
  // ---------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------
// WIDGET D'UN JOUR DU MINI CALENDRIER
// -----------------------------------------------------------------------------

class _CalendarDay extends StatelessWidget {
  final String label;
  final String day;

  const _CalendarDay({required this.label, required this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            day,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
      ],
    );
  }
}
