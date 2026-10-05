import 'package:flutter/material.dart';
import 'package:mes_depenses/navigation/butom_navigation_bar.dart';
import 'package:mes_depenses/pages/acceuil/aceuil_page.dart';
import 'package:mes_depenses/pages/acceuil/pages/page1.dart';
import 'package:mes_depenses/pages/authentification/connexion_inscription_page.dart';
import 'package:mes_depenses/connexion.dart';
import 'package:mes_depenses/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     
      home:  AceuilPage()
    );
  }
}

