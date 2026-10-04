import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 8),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Onglets
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => setState(() => isLogin = true),
                    child: Text(
                      "Connexion",
                      style: TextStyle(
                        fontWeight: isLogin ? FontWeight.bold : FontWeight.normal,
                        color: isLogin ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => isLogin = false),
                    child: Text(
                      "Créer un compte",
                      style: TextStyle(
                        fontWeight: !isLogin ? FontWeight.bold : FontWeight.normal,
                        color: !isLogin ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Formulaire
              isLogin ? _buildLoginForm() : _buildRegisterForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        TextField(decoration: InputDecoration(labelText: "E-mail")),
        TextField(
          decoration: InputDecoration(labelText: "Mot de passe"),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // TODO: Firebase Auth signIn
          },
          child: const Text("Se connecter"),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      children: [
        TextField(decoration: InputDecoration(labelText: "E-mail")),
        TextField(decoration: InputDecoration(labelText: "Mot de passe"), obscureText: true),
        TextField(decoration: InputDecoration(labelText: "Confirmer le mot de passe"), obscureText: true),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // TODO: Firebase Auth createUser
          },
          child: const Text("Créer un compte"),
        ),
      ],
    );
  }
}
