import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mes_depenses/navigation/butom_navigation_bar.dart';
import 'package:mes_depenses/pages/authentification/connexion.dart';
import 'package:mes_depenses/pages/authentification/inscription_page.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/pages/questions/questions_page.dart';
import 'package:mes_depenses/provider/user_provider.dart';
import 'package:mes_depenses/widget/awesome_dialog_error.dart';
import 'package:provider/provider.dart';

class ConnexionInscriptionPage extends StatefulWidget {
  const new({super.key});

  @override
  State<ConnexionInscriptionPage> createState() =>
      _ConnexionInscriptionPageState();
}

class _ConnexionInscriptionPageState extends State<ConnexionInscriptionPage> {
  bool isLogin = true;
  GlobalKey<FormState> key = new GlobalKey();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nomController = new TextEditingController();
  bool isLoading = false;
  // fonction pour creation compte
  Future<void> creerCompte() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "nom": nomController.text.trim(),
        "email": emailController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
        "onboardingCompleted": false,
      });

      setState(() {
        isLoading = false;
      });
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setName(nomController.text.trim());
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setEmail(emailController.text.trim());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => QuestionsPage(uid: uid)),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ShowDialog(
          context,
          "Cet email est déjà utilisé. Connecte-toi à la place.",
        );
      } else if (e.code == 'invalid-email') {
        "L'adresse email n'est pas valide.";
      } else if (e.code == 'weak-password') {
        "Mot de passe trop faible (6 caractères minimum).";
      } else {
        print("Erreur : ${e.code}");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  // fonction pour la connexion

  Future<void> userConnxion() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final uid = userCredential.user!.uid;

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();
      setState(() {
        isLoading = false;
      });
      // nom
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setName(documentSnapshot['nom']);

      // email
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setEmail(documentSnapshot['email']);
      Provider.of<UserProvider>(context, listen: false).setId(uid);

      if (documentSnapshot['onboardingCompleted'] != false) {
        Provider.of<UserProvider>(context, listen: false).setCurrency(
          documentSnapshot['currencyCode'],

          documentSnapshot['currencyName'],
          documentSnapshot['currencySymbole'],
        );
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).setBudget(documentSnapshot['budgetMaxe']);
      }
      if (documentSnapshot['onboardingCompleted'] != false) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => ButomNavigationBarPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => QuestionsPage(uid: uid)),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        ShowDialog(context, "Ce compte a été désactivé");
      } else if (e.code == 'invalid-email') {
        ShowDialog(context, "Email invalide");

        print('Adresse email invalide.');
      } else if (e.code == 'user-disabled') {
        ShowDialog(context, "Mot de passe invalide");
      } else {
        print('Erreur de connexion : ${e.code}');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWith * 0.07, vertical: screenHeigth * 0.03),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeigth * 0.03),
                  Container(
                    height: screenHeigth * 0.06,
                    width: screenWith * 0.12,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(screenWith * 0.03),
                    ),
                    child: Icon(
                      Icons.trending_up,
                      color: Colors.white,
                      size: screenWith * 0.06,
                    ),
                  ),
                  SizedBox(height: screenHeigth * 0.02),

                  Text(
                    "Content de te revoir",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWith * 0.064,
                    ),
                  ),
                  SizedBox(height: screenHeigth * 0.002),
                  Text(
                    isLogin
                        ? "Connectez-vous pour suivre vos dépenses."
                        : "Créer votre compte pour suivre vos dépenses.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWith * 0.037,
                    ),
                  ),
                  SizedBox(height: screenHeigth * 0.036),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.tabBackground,
                      borderRadius: BorderRadius.circular(screenWith * 0.03),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWith * 0.02),
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
                                padding:  EdgeInsets.symmetric(
                                  vertical: screenHeigth * 0.015,
                                ),
                                decoration: BoxDecoration(
                                  color: isLogin
                                      ? Colors.white
                                      : AppColors.tabBackground,
                                  borderRadius: BorderRadius.circular(screenWith * 0.022),
                                ),
                                child: Center(
                                  child: Text(
                                    "Connexion",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWith * 0.042,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenHeigth * 0.015),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isLogin = false;
                                });
                              },
                              child: Container(
                                padding:  EdgeInsets.symmetric(
                                  vertical: screenHeigth * 0.015,
                                ),
                                decoration: BoxDecoration(
                                  color: isLogin
                                      ? AppColors.tabBackground
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(screenWith * 0.022),
                                ),
                                child: Center(
                                  child: Text(
                                    "Créer un compte",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWith * 0.042,
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
                  SizedBox(height: screenHeigth * 0.03),
                  isLogin
                      ? Connexion(
                          emailController: emailController,
                          passwordController: passwordController,
                        )
                      : InscriptionPage(
                          eamilController: emailController,
                          nomController: nomController,
                          passwordController: passwordController,
                        ),

                  SizedBox(height: isLogin ? screenHeigth * 0.099 : screenHeigth * 0.074),
                  InkWell(
                    onTap: () {
                      if (key.currentState!.validate()) {
                        isLogin ? userConnxion() : creerCompte();
                      }
                    },
                    child: Container(
                      height: screenHeigth * 0.062,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(screenWith * 0.03),
                      ),
                      child: Center(
                        child: isLoading
                            ? SizedBox(
                                width: screenWith * 0.06,
                                height: screenHeigth * 0.028,
                                child: CircularProgressIndicator(
                                  strokeWidth: screenWith * 0.005,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                isLogin ? "Se connecter" : "Créer votre compte",
                                style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWith * 0.040 ,
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
}
