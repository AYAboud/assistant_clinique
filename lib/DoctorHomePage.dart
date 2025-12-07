import 'package:flutter/material.dart';
import 'dart:math';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
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

      //-------------------------------------- BODY --------------------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- PROFILE CARD ----------------
            _profileCard(),

            const SizedBox(height: 25),

            // ---------------- MINI CALENDAR ----------------
            const Text(
              "Mon Calendrier",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _miniCalendar(),

            const SizedBox(height: 25),

            // ---------------- STATISTICS GRAPH ----------------
            const Text(
              "Statistiques hebdomadaires",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _statisticsCard(),

            const SizedBox(height: 25),

            // ---------------- QUICK ACTIONS ----------------
            const Text(
              "Actions rapides",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _quickActions(context),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // PROFILE CARD
  // -------------------------------------------------------------------------
  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage("assets/doctor.jpg"),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Dr. Ahmed Salmi",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "Cardiologue",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // MINI CALENDAR
  // -------------------------------------------------------------------------
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

  // -------------------------------------------------------------------------
  // STATISTICS GRAPH
  // -------------------------------------------------------------------------
  Widget _statisticsCard() {
    List<double> weeklyData = [3, 5, 6, 4, 7, 2, 5];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: SizedBox(
        height: 200,
        child: CustomPaint(painter: LineChartPainter(weeklyData)),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // QUICK ACTIONS
  // -------------------------------------------------------------------------
  Widget _quickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionCard(
          icon: Icons.calendar_month,
          color: Colors.teal,
          title: "Planning",
          onTap: () {
            Navigator.pushNamed(context, "/doctorSchedule");
          },
        ),
        _actionCard(
          icon: Icons.person_search,
          color: Colors.blueAccent,
          title: "Patients",
          onTap: () {},
        ),
        _actionCard(
          icon: Icons.history,
          color: Colors.orangeAccent,
          title: "Historiques",
          onTap: () {},
        ),
      ],
    );
  }

  Widget _actionCard({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 100,
        height: 115,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 34),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PAINTER FOR SIMPLE LINE CHART
// -----------------------------------------------------------------------------
class LineChartPainter extends CustomPainter {
  final List<double> values;
  LineChartPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.teal
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    double spacing = size.width / (values.length - 1);
    double maxValue = values.reduce(max);

    for (int i = 0; i < values.length; i++) {
      double x = i * spacing;
      double y = size.height - (values[i] / maxValue * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
