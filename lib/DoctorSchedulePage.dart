import 'package:flutter/material.dart';

class DoctorSchedulePage extends StatefulWidget {
  const DoctorSchedulePage({super.key});

  @override
  State<DoctorSchedulePage> createState() => _DoctorSchedulePageState();
}

class _DoctorSchedulePageState extends State<DoctorSchedulePage> {
  Map<String, List<Map<String, TimeOfDay>>> schedule = {
    "Lundi": [],
    "Mardi": [],
    "Mercredi": [],
    "Jeudi": [],
    "Vendredi": [],
    "Samedi": [],
    "Dimanche": [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text("Mon Planning"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: schedule.keys.map((day) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            child: ExpansionTile(
              title: Text(
                day,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              children: [
                Column(
                  children: [
                    ...schedule[day]!.map((slot) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${slot['start']!.format(context)} - ${slot['end']!.format(context)}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  schedule[day]!.remove(slot);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    // ----------------------------------------------
                    // 🔥 Nouveau bouton "Ajouter un créneau"
                    // ----------------------------------------------
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          TimeOfDay? start = await showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 9, minute: 0),
                          );
                          if (start == null) return;

                          TimeOfDay? end = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                              hour: start.hour + 1,
                              minute: start.minute,
                            ),
                          );
                          if (end == null) return;

                          setState(() {
                            schedule[day]!.add({'start': start, 'end': end});
                          });
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          "Ajouter un créneau",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style:
                            ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1ABC9C),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ).copyWith(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(
                                      MaterialState.pressed,
                                    )) {
                                      return const Color(
                                        0xFF16A085,
                                      ); // foncé au press
                                    }
                                    return const Color(0xFF1ABC9C);
                                  }),
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
