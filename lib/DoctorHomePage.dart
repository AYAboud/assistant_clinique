import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'PatientHomePage.dart';
import 'consultations_page.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  int totalConsultations = 0;
  int planned = 0;
  int done = 0;
  int canceled = 0;
  int distinctPatients = 0;
  Map<int, int> consultationsPerDay = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  Future<void> fetchStats() async {
    final doctorId = 1; // à rendre dynamique si besoin
    try {
      final totalRes = await http.get(
        Uri.parse('http://localhost:8082/consultations/doctor/$doctorId/count'),
      );
      final plannedRes = await http.get(
        Uri.parse(
          'http://localhost:8082/consultations/doctor/$doctorId/count/status/PLANNED',
        ),
      );
      final doneRes = await http.get(
        Uri.parse(
          'http://localhost:8082/consultations/doctor/$doctorId/count/status/DONE',
        ),
      );
      final canceledRes = await http.get(
        Uri.parse(
          'http://localhost:8082/consultations/doctor/$doctorId/count/status/CANCELED',
        ),
      );
      final patientsRes = await http.get(
        Uri.parse(
          'http://localhost:8082/consultations/doctor/$doctorId/count/patients',
        ),
      );
      final statsRes = await http.get(
        Uri.parse(
          'http://localhost:8082/consultations/doctor/$doctorId/stats/days',
        ),
      );

      setState(() {
        totalConsultations = int.parse(totalRes.body);
        planned = int.parse(plannedRes.body);
        done = int.parse(doneRes.body);
        canceled = int.parse(canceledRes.body);
        distinctPatients = int.parse(patientsRes.body);
        Map<String, dynamic> data = json.decode(statsRes.body);
        consultationsPerDay = data.map(
          (key, value) => MapEntry(int.parse(key), (value as num).toInt()),
        );
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

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
            onPressed: () => Scaffold.of(context).openDrawer(),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Calendrier",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _miniCalendar(),
                  const SizedBox(height: 30),
                  const Text(
                    "Statistiques clés",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30, width: 20),
                  Wrap(
                    alignment:
                        WrapAlignment.center, // 👈 THIS centers the cards
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _statCard("Total", totalConsultations, Colors.teal),
                      _statCard("PLANNED", planned, Colors.orange),
                      _statCard("DONE", done, Colors.green),
                      _statCard("CANCELED", canceled, Colors.red),
                      _statCard("Patients", distinctPatients, Colors.blue),
                    ],
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    "Graphiques",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // ---------------- Bar Chart ----------------
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: consultationsPerDay.values.isEmpty
                            ? 1
                            : consultationsPerDay.values
                                  .reduce((a, b) => a > b ? a : b)
                                  .toDouble(),
                        barGroups: consultationsPerDay.entries
                            .map(
                              (e) => BarChartGroupData(
                                x: e.key,
                                barRods: [
                                  BarChartRodData(
                                    toY: e.value.toDouble(),
                                    color: Colors.teal,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ---------------- Pie Chart ----------------
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: planned.toDouble(),
                            color: Colors.orange,
                            title: "PLANNED",
                          ),
                          PieChartSectionData(
                            value: done.toDouble(),
                            color: Colors.green,
                            title: "DONE",
                          ),
                          PieChartSectionData(
                            value: canceled.toDouble(),
                            color: Colors.red,
                            title: "CANCELED",
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // TODO: Ajouter LineChart pour évolution hebdomadaire
                ],
              ),
            ),
    );
  }

  Widget _statCard(String label, int value, Color color) {
    return Container(
      width: 150,
      height: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$value",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
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
        boxShadow: const [
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
  // DRAWER
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
          ListTile(
            leading: const Icon(Icons.person, color: Colors.deepPurple),
            title: const Text("Profil"),
            onTap: () => Navigator.pushNamed(context, "/doctorProfile"),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month, color: Colors.teal),
            title: const Text("Mon planning"),
            onTap: () => Navigator.pushNamed(context, "/doctorSchedule"),
          ),
          ListTile(
            leading: const Icon(Icons.person_search, color: Colors.blue),
            title: const Text("Mes patients"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PatientHomePage()),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.medical_services,
              color: Colors.redAccent,
            ),
            title: const Text("Rendez-vous"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConsultationsPage(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.orange),
            title: const Text("Historiques"),
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Déconnexion"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
