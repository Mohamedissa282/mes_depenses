import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/provider/budget_provider.dart';
import 'package:mes_depenses/provider/user_provider.dart';
import 'package:mes_depenses/widget/awesome_dialog_error.dart';
import 'package:mes_depenses/widget/awesome_dialog_succes.dart';
import 'package:provider/provider.dart';

class AjouteDepense extends StatefulWidget {
  const new({super.key});

  @override
  State<AjouteDepense> createState() => _AjouteDepenseState();
}

class _AjouteDepenseState extends State<AjouteDepense> {
  TextEditingController montantController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  String selectedCategorie = "Sorties";
  DateTime dateTime = new DateTime.now();

  bool isLoading = false;

  Future<void> ajouteDepense() async {
    try {
      setState(() {
        isLoading = true;
      });
      final uid = Provider.of<UserProvider>(context, listen: false).idUser;
      DateTime now = DateTime.now();
      String moisActuel = DateFormat('MMMM', 'fr_FR').format(now);
      int anneeActuelle = now.year;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("expenses")
          .add({
            "montant": double.tryParse(montantController.text) ?? 0.0,
            "categorie": selectedCategorie,
            "note": noteController.text.trim(),
            "date": now,
            "mois": moisActuel,
            "annee": anneeActuelle,
          });

      setState(() {
        isLoading = false;
      });
      final budgetProvider = Provider.of<Budgetprovider>(
        context,
        listen: false,
      );
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      budgetProvider.chargerDepensesDuMois(
        userProvider.idUser,
        userProvider.budegtMax,
      );

      ShowDialogSucces(context, "La dépense à été ajouté avec succes");
    } catch (e) {
      print("###################### ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    final budgetProvider = Provider.of<Budgetprovider>(
        context,
        
      );
      final userProvider = Provider.of<UserProvider>(context);
    DateTime now = DateTime.now();
    String moisActuel = DateFormat('MMMM', 'fr_FR').format(now);
    int anneeActuelle = now.year;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:screenWith * 0.043 , vertical: screenHeigth * 0.040),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nouvelle dépense",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWith * 0.044),
                  ),
                  SizedBox(height: screenHeigth * 0.015),
                  Text(
                    "Veuillez sasir le montant",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWith * 0.036,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: screenHeigth * 0.010),
                  TextFormField(
                    controller: montantController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez ajouter le montant";
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText:
                          "0 ${Provider.of<UserProvider>(context).currencySymbole}",
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWith * 0.032),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeigth * 0.040),
                  Text(
                    "Catégorie",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWith * 0.040),
                  ),
                  SizedBox(height: screenHeigth * 0.010),
                  Wrap(
                    spacing: screenWith * 0.016,
                    runSpacing: screenHeigth * 0.012,
                    children: [
                      Categorie("Sorties"),
                      Categorie("Études"),
                      Categorie("Restaurant"),
                      Categorie("Transport"),
                      Categorie("Santé"),
                      Categorie("Sport"),
                      Categorie("Autres"),
                    ],
                  ),
                  SizedBox(height: screenHeigth * 0.046),

                  Text(
                    "Note(facultatif)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWith * 0.040),
                  ),
                  SizedBox(height: screenHeigth * 0.012),
                  TextFormField(
                    controller: noteController,
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
                        borderRadius: BorderRadius.circular(screenWith * 0.032),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                   SizedBox(height: screenHeigth * 0.13),

                  Container(
                    height: screenHeigth * 0.055,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWith * 0.032),
                      color: Color(0xFFD9EEE9),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(11.0),
                      child: Center(
                        child: Text(
                          "Il vous restera ${budgetProvider.resteBudget} ${userProvider.currencySymbole} pour mois ${moisActuel}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWith * 0.038,
                            color: AppColors.primaryLight
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeigth * 0.020),
                  InkWell(
                    onTap: () {
                      if (key.currentState!.validate()) {
                        ajouteDepense();
                        montantController.clear();
                        noteController.clear();
                        setState(() {
                          selectedCategorie = "Sorties";
                        });
                      }
                    },
                    child: Container(
                      height: screenHeigth * 0.062,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(screenWith * 0.032),
                      ),
                      child: Center(
                        child: isLoading
                            ? SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Enregistrer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWith * 0.040,
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
      ),
    );
  }

  Widget Categorie(String nom) {
     double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    bool isSelected = selectedCategorie == nom;
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategorie = nom;
        });
      },
      child: Container(
        height: screenHeigth * 0.053,
        width: screenWith * 0.21,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(screenWith * 0.065),
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
