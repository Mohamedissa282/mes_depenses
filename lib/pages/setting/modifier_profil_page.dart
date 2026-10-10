import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/provider/budget_provider.dart';
import 'package:mes_depenses/provider/monaie_budget.dart';
import 'package:mes_depenses/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ModifierProfilPage extends StatefulWidget {
  const new({super.key});

  @override
  State<ModifierProfilPage> createState() => _ModifierProfilPageState();
}

class _ModifierProfilPageState extends State<ModifierProfilPage> {
  bool isLoading = false;
  TextEditingController budgetController = TextEditingController();
  TextEditingController nomController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  Future<void> modiferProfil() async {
    try {
      setState(() {
        isLoading = true;
      });
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      final budgetProvider = Provider.of<Budgetprovider>(
        context,
        listen: false,
      );
      double budget = double.tryParse(budgetController.text) ?? 0.0;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userProvider.idUser)
          .update({"nom": nomController.text.trim(), "budgetMaxe": budget});

      setState(() {
        isLoading = false;
       userProvider.setName(nomController.text.trim());

        userProvider.setBudget(budget);
        budgetProvider.chargerDepensesDuMois(
          userProvider.idUser,
          userProvider.budegtMax,
        );
        Navigator.of(context).pop();
      });
    } catch (e) {
      print("################################# ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          "Modifier Profil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWith * 0.039, vertical: screenHeigth * 0.045),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Container(
                    height: screenHeigth * 0.088,
                    width: screenWith * 0.19,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(screenWith * 0.090),
                    ),
                    child: Center(
                      child: Text(
                        userProvider.nom[0].toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: screenWith * 0.070,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeigth * 0.066),
                Text(
                  "Nom",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWith * 0.038,
                  ),
                ),
                SizedBox(height: screenHeigth * 0.012),
                TextFormField(
                  controller: nomController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "nom est obligatoire.";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWith * 0.025),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.border),
                      borderRadius: BorderRadius.circular(screenWith * 0.025),
                    ),
                    hintText: "entrez votre nom",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                SizedBox(height: screenHeigth * 0.027),
                Text(
                  "Saisir nouvelle budget max",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWith * 0.038,
                  ),
                ),
                SizedBox(height: screenHeigth * 0.012),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Saiasir votre budget";
                    }
                  },
                  controller: budgetController,
                 
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "ton budget max",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[400],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWith * 0.027),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: screenHeigth * 0.30),
                InkWell(
                  onTap: () {
                    if (key.currentState!.validate()) {
                      modiferProfil();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
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
}
