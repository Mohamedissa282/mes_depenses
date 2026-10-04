import 'package:flutter/material.dart';
import 'package:mes_depenses/pages/authentification/connexion.dart';
import 'package:mes_depenses/pages/authentification/inscription_page.dart';
import 'package:mes_depenses/color.dart';

class ConnexionInscriptionPage extends StatefulWidget {
  const new({super.key});

  @override
  State<ConnexionInscriptionPage> createState() =>
      _ConnexionInscriptionPageState();
}

class _ConnexionInscriptionPageState extends State<ConnexionInscriptionPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(Icons.trending_up, color: Colors.white, size: 22),
                ),
                SizedBox(height: 23),

                Text(
                  "Content de te revoir",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 4),
                Text( isLogin ?
                  "Connectez-vous pour suivre vos dépenses." : "Créer votre compte pour suivre vos dépenses.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 30),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.tabBackground,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isLogin = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isLogin
                                    ? Colors.white
                                    : AppColors.tabBackground,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Center(
                                child: Text(
                                  "Connexion",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isLogin = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isLogin
                                    ? AppColors.tabBackground
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Center(
                                child: Text(
                                  "Créer un compte",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                isLogin ? Connexion() : InscriptionPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
