import 'package:flutter/material.dart';
import 'DoctorSchedulePage.dart';

// --- (Optionnel) Classe Doctor pour la cohérence des données ---
class Doctor {
  String firstName;
  String lastName;
  String specialty;
  String phone;
  String email;
  String dailyStartHour;
  String dailyEndHour;

  Doctor({
    required this.firstName,
    required this.lastName,
    required this.specialty,
    required this.phone,
    required this.email,
    required this.dailyStartHour,
    required this.dailyEndHour,
  });
}

// --- Écran Principal ---
class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  // Clé pour le formulaire, utilisée pour valider les champs
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour les champs de texte
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Variables pour les champs spécifiques
  String? _selectedSpecialty;
  TimeOfDay _dailyStartTime = const TimeOfDay(hour: 9, minute: 0); // 09:00
  TimeOfDay _dailyEndTime = const TimeOfDay(hour: 17, minute: 0); // 17:00

  // Liste des spécialités disponibles
  final List<String> _specialties = [
    'Cardiologie',
    'Dermatologie',
    'Généraliste',
    'Pédiatrie',
    'Neurologie',
    'Ophtalmologie',
  ];

  // Fonction pour afficher le sélecteur d'heure
  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _dailyStartTime : _dailyEndTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _dailyStartTime = picked;
        } else {
          _dailyEndTime = picked;
        }
      });
    }
  }

  // Fonction appelée lorsque l'utilisateur clique sur "Mettre à jour"
  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      // Les données sont valides, on peut les envoyer à l'API Spring Boot ici.
      final newDoctorProfile = Doctor(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        specialty: _selectedSpecialty ?? 'Non spécifiée',
        phone: _phoneController.text,
        email: _emailController.text,
        dailyStartHour: _dailyStartTime.format(context),
        dailyEndHour: _dailyEndTime.format(context),
      );

      // --- TODO: Appeler l'API POST/PUT ici ---
      // Exemple de données à envoyer :
      print('Profil mis à jour :');
      print(
        'Nom: ${newDoctorProfile.lastName}, Spécialité: ${newDoctorProfile.specialty}',
      );
      print(
        'Heures: ${newDoctorProfile.dailyStartHour} - ${newDoctorProfile.dailyEndHour}',
      );

      // Afficher une confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil mis à jour avec succès!')),
      );
    }
  }

  // Formatage de l'heure
  String _formatTimeOfDay(TimeOfDay time) {
    // Utilise le format 24h ou 12h selon la locale du téléphone
    return time.format(context);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: _updateProfile,
            child: const Text(
              'Enregistrer',
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- 1. Photo de Profil ---
              _buildProfilePicture(),

              const SizedBox(height: 30),

              // --- 2. Informations Personnelles ---
              const Text(
                'Informations Personnelles',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Divider(height: 15, thickness: 1),

              _buildInputField(
                controller: _firstNameController,
                labelText: 'Prénom',
                icon: Icons.person_outline,
              ),
              _buildInputField(
                controller: _lastNameController,
                labelText: 'Nom de famille',
                icon: Icons.group_outlined,
              ),
              _buildSpecialtyDropdown(),

              _buildInputField(
                controller: _phoneController,
                labelText: 'Téléphone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              _buildInputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 30),
              Text(
                'Planning',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Divider(height: 15, thickness: 1),

              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                ), // espace avant/après
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DoctorSchedulePage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.schedule, color: Colors.teal),
                  label: const Text(
                    "Définir mon planning",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.teal, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white, // bouton clair
                    foregroundColor: Colors.teal,
                    elevation: 0,
                  ),
                ),
              ),

              // --- 4. Bouton d'Action ---
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Mettre à jour le profil',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFFE0F7FA), // Light Teal Background
            child: Icon(Icons.person, size: 60, color: Colors.teal),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget générique pour les champs de texte
  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: Colors.teal.shade300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.teal.shade100),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ce champ est requis';
          }
          return null;
        },
      ),
    );
  }

  // Widget pour le menu déroulant des spécialités
  Widget _buildSpecialtyDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Spécialité',
          prefixIcon: Icon(
            Icons.medical_services_outlined,
            color: Colors.teal.shade300,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.teal.shade100),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        initialValue: _selectedSpecialty,
        hint: const Text('Sélectionnez votre spécialité'),
        items: _specialties.map((String specialty) {
          return DropdownMenuItem<String>(
            value: specialty,
            child: Text(specialty),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedSpecialty = newValue;
          });
        },
        validator: (value) =>
            value == null ? 'Veuillez choisir une spécialité' : null,
      ),
    );
  }

  // Widget pour le sélecteur d'heures de début et de fin
  Widget _buildHoursPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // Heure de début
        Expanded(
          child: _buildTimeBox(
            context,
            'Heure de début',
            _dailyStartTime,
            () => _selectTime(context, true),
          ),
        ),
        const SizedBox(width: 15),
        // Heure de fin
        Expanded(
          child: _buildTimeBox(
            context,
            'Heure de fin',
            _dailyEndTime,
            () => _selectTime(context, false),
          ),
        ),
      ],
    );
  }

  // Boîte individuelle pour l'heure
  Widget _buildTimeBox(
    BuildContext context,
    String label,
    TimeOfDay time,
    VoidCallback onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.access_time, color: Colors.teal.shade300),
                const SizedBox(width: 8),
                Text(
                  _formatTimeOfDay(time),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
