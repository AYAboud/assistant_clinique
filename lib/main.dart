import 'package:flutter/material.dart';
import 'AuthPage.dart'; // Assure-toi que le fichier est bien importé
import 'doctor_profile_screen.dart'; // Assurez-vous d'importer le fichier

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
        scaffoldBackgroundColor: const Color(0xFFF0F5F5), // Fond très clair pour correspondre au design
        appBarTheme: const AppBarTheme(
          color: Color(0xFFF0F5F5),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: const AuthPage(), // Démarrez avec l'écran du profil
    );
  }
}