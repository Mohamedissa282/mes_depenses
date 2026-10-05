import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';

class InscriptionPage extends StatefulWidget {
  const new({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();

  
}

class _InscriptionPageState extends State<InscriptionPage> {

  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nom",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 3),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "nom est obligatoire.";
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(11),
              ),
              hintText: "entrez votre nom",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 15),
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
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(11),
              ),
              hintText: "nom@example.com",
              prefixIcon: Icon(Icons.email),
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
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppColors.primaryLight,
                ),
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

        
        ],
      );
    
  }
}
