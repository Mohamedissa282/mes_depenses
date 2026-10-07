import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';

class Connexion extends StatefulWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const new({super.key, required this.emailController, required this.passwordController});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

 
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "E-mail",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 3),
          TextFormField(
            controller: widget.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email est obligatoire.";
              }
              bool email = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                  .hasMatch(value);

              if (!email) {
                return "email non valide";
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(color: AppColors.border),
              ),
              prefixIcon: Icon(Icons.email),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(11),
              ),
              hintText: "nom@example.com",
            ),
          ),
          SizedBox(height: 15),

          Text(
            "Mot de passe",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 3),
          TextFormField(
            obscureText: _obscurePassword,
            controller: widget.passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "mot de passe est obligatoire.";
              }

              if (value.length < 4) {
                return "mot de passe non valide";
              }
            },
            decoration: InputDecoration(
              hintText: "mot de passe",
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppColors.primaryLight,),
              ),
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Mot de passe oublié ?",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
       
        ],
      );
    
  }
}
