import 'package:flutter/material.dart';
import 'doctor_profile_screen.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  String selectedRole = "Patient"; 
  String role = "Patient"; 

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5F0),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Logo
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.health_and_safety,
                  size: 60,
                  color: Color(0xFF2CC295),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                isLogin ? "Connexion" : "Créer un compte",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                isLogin
                    ? "Accédez à votre espace"
                    : "Créez votre compte utilisateur",
                style: TextStyle(color: Colors.grey[600]),
              ),

              const SizedBox(height: 30),

              // Toggle rôle connexion
              if (isLogin)
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text("Patient"),
                        selected: role == "Patient",
                        onSelected: (selected) {
                          setState(() {
                            role = "Patient";
                          });
                        },
                        selectedColor: const Color(0xFF2CC295),
                        labelStyle: TextStyle(
                          color: role == "Patient" ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text("Docteur"),
                        selected: role == "Docteur",
                        onSelected: (selected) {
                          setState(() {
                            role = "Docteur";
                          });
                        },
                        selectedColor: const Color(0xFF2CC295),
                        labelStyle: TextStyle(
                          color: role == "Docteur" ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

              // Email
              _buildInputField(
                label: "Email",
                icon: Icons.email_outlined,
                controller: emailController,   // 🔥 ajouté
              ),

              const SizedBox(height: 15),

              // Password
              _buildInputField(
                label: "Mot de passe",
                icon: Icons.lock_outline,
                obscure: true,
                controller: passwordController, // 🔥 ajouté
              ),

              // Inscription
              if (!isLogin) ...[
                const SizedBox(height: 15),
                _buildInputField(
                  label: "Confirmer le mot de passe",
                  icon: Icons.lock_reset,
                  obscure: true,
                ),

                const SizedBox(height: 15),

                // Choix rôle inscription
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Choisissez un rôle",
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Patient",
                        child: Text("Patient"),
                      ),
                      DropdownMenuItem(
                        value: "Docteur",
                        child: Text("Docteur"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value!;
                      });
                    },
                  ),
                ),
              ],

              const SizedBox(height: 30),

              // Bouton Connexion
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFF2CC295),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextButton(
                  onPressed: () {
                    if (isLogin) {
                    // 🔥 LOGIQUE SIMPLE DE CONNEXION
                      String email = emailController.text.trim();
                      String pass = passwordController.text.trim();

                      if (email == "a" && pass == "a") {
                            // 🔥 REDIRECTION vers la page du docteur
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                             builder: (context) => const DoctorProfileScreen(),
                          ),
                        );
                     } else {
                       ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Identifiants incorrects ❌")),
                       );
                     }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text("Inscription simulée ✔")),
                      );
                    }
                  },

                  child: Text(
                    isLogin ? "Se connecter" : "S’inscrire",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin
                        ? "Vous n’avez pas de compte ?"
                        : "Vous avez déjà un compte ?",
                    style: const TextStyle(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin ? "Créer un compte" : "Connexion",
                      style: const TextStyle(
                        color: Color(0xFF2CC295),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              if (isLogin)
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Mot de passe oublié ?",
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 buildInputField MODIFIÉ AVEC controller
  Widget _buildInputField({
    required String label,
    required IconData icon,
    bool obscure = false,
    TextEditingController? controller, // ajouté
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: TextField(
        controller: controller, // ajouté
        obscureText: obscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          icon: Icon(icon, color: const Color(0xFF2CC295)),
        ),
      ),
    );
  }
}
