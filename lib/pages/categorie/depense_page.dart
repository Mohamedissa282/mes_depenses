import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';

class AjouteDepense extends StatefulWidget {
  const new({super.key});

  @override
  State<AjouteDepense> createState() => _AjouteDepenseState();
}

class _AjouteDepenseState extends State<AjouteDepense> {
  String selectedCategorie = "";
  DateTime dateTime = new DateTime.now();

  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        dateTime = DateTime.now();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 27),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nouvelle dépense",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 14),
                Text(
                  "Veuillez sasir le montant",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 6),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "0 £",
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 30),
                Text(
                  "Catégorie",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 9,
                  runSpacing: 10,
                  children: [
                    Categorie("Restaurant"),
                    Categorie("Etudes"),
                    Categorie("Sortie"),
                    Categorie("Transport"),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Date",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 7),
                Text(
                  "${dateTime.day}/${dateTime.month}/${dateTime.year}. ${dateTime.hour}h : ${dateTime.minute}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),

                SizedBox(height: 40),
                Text(
                  "Note(facultatif)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 8),
                TextFormField(
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Ex: déjeuner",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 120),
                InkWell(
                  onTap: () {
                    print("############  ${dateTime}");
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Enregistrer",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Categorie(String nom) {
    bool isSelected = selectedCategorie == nom;
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategorie = nom;
        });
      },
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            nom,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
