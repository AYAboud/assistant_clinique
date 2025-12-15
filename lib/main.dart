import 'package:flutter/material.dart';
import 'AuthPage.dart'; // Assure-toi que le fichier est bien importé

import 'doctor_profile_screen.dart';
import 'DoctorHomePage.dart';
import 'DoctorSchedulePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(
          0xFFF0F5F5,
        ), // Fond très clair pour correspondre au design
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF0F5F5),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const AuthPage(), // Démarrez avec l'écran du profil
      routes: {
        "/doctorProfile": (context) => const DoctorProfileScreen(),
        "/dashboard": (context) => const DoctorHomePage(),
        "/schedule": (context) => const DoctorSchedulePage(),
        // ajoute ce que tu veux…
      },
    );
  }
}
