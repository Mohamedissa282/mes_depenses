import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/pages/acceuil/aceuil_page.dart';
import 'package:mes_depenses/pages/categorie/depense_page.dart';
import 'package:mes_depenses/pages/historique/historique_page.dart';
import 'package:mes_depenses/pages/home/home_page.dart';
import 'package:mes_depenses/pages/setting/profil_page.dart';

class ButomNavigationBarPage extends StatefulWidget {
  const new({super.key});

  @override
  State<ButomNavigationBarPage> createState() => _ButomNavigationBarState();
}

class _ButomNavigationBarState extends State<ButomNavigationBarPage> {
  int slected = 0;
  List<Widget> pages = [
    HomePage(),
    HistoriquePage(),
    AjouteDepense(),
    ProfilPage(),
  ];

  void _onTap(int i) {
    setState(() {
      slected = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: slected,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedLabelStyle:  TextStyle(fontWeight: FontWeight.w700),
        unselectedLabelStyle:  TextStyle(fontWeight: FontWeight.w500),
        backgroundColor: AppColors.surface,
       elevation: 0,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Aceuil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Historique",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "Catégorie",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),

      body: IndexedStack(index: slected, children: pages),
    );
  }
}
