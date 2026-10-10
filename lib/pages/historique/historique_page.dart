import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lottie/lottie.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/color/categorie_color.dart';
import 'package:mes_depenses/provider/user_provider.dart';
import 'package:mes_depenses/utils/date_formatter.dart';
import 'package:provider/provider.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  List<String> moisList = [];
  String moisSelectionne = "";
  bool isLoding = true;
  List<QueryDocumentSnapshot> depenses = [];
  Map<String, double> dataGraphique = {};

  @override
  void initState() {
    super.initState();
    chargerTousLesMois();
  }

  // Charger tous les mois disponibles
  Future<void> chargerTousLesMois() async {
    setState(() {
      isLoding = true;
    });
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userProvider.idUser)
        .collection("expenses")
        .orderBy("date", descending: true)
        .get();

    setState(() {
      isLoding = false;
    });
    Set<String> mois = {};

    for (var doc in snapshot.docs) {
      mois.add("${doc['mois']} ${doc['annee']}");
    }

    setState(() {
      moisList = mois.toList();
      if (moisList.isNotEmpty) {
        moisSelectionne = moisList.first;
      }
    });

    if (moisSelectionne.isNotEmpty) {
      chargerDepensesDuMois(moisSelectionne);
    }
  }

  // Charger les dépenses du mois sélectionné
  Future<void> chargerDepensesDuMois(String mois) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final parts = mois.split(" ");
    final moisTexte = parts[0];
    final annee = int.parse(parts[1]);

    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("expenses")
        .where("mois", isEqualTo: moisTexte)
        .where("annee", isEqualTo: annee)
        .get();

    setState(() {
      depenses = snapshot.docs;
    });

    calculerGraphique();
  }

  // Calculer les montants par catégorie
  void calculerGraphique() {
    Map<String, double> categories = {};

    for (var d in depenses) {
      final cat = d['categorie'];
      final montant = d['montant'] * 1.0;

      categories[cat] = (categories[cat] ?? 0) + montant;
    }

    setState(() {
      dataGraphique = categories;
    });
  }

  // Couleurs par catégorie
  Color couleurCategorie(String cat) {
    switch (cat.toLowerCase()) {
      case "restaurant":
        return const Color(0xFFFFA726); // Orange
      case "transport":
        return const Color(0xFF29B6F6); // Bleu clair
      case "santé":
        return const Color(0xFFE53935); // Rouge
      case "sport":
        return const Color(0xFF43A047); // Vert
      case "études":
        return const Color(0xFF7E57C2); // Violet
      case "sorties":
        return const Color(0xFFEC407A); // Rose
      case "autres":
        return const Color(0xFFBDBDBD); // Gris
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Historique",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWith * 0.057,
                ),
              ),

              SizedBox(height: screenHeigth * 0.020),

              isLoding
                  ? Align(
                      alignment: AlignmentGeometry.center,
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: screenHeigth * 0.050,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: moisList.length,
                        itemBuilder: (context, index) {
                          final m = moisList[index];
                          final isSelected = m == moisSelectionne;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                moisSelectionne = m;
                              });
                              chargerDepensesDuMois(m);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: screenWith * 0.010),
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWith * 0.020,
                                vertical: screenHeigth * 0.011,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(screenWith * 0.058),
                              ),
                              child: Text(
                                m,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

              SizedBox(height: screenHeigth * 0.023),

              if (dataGraphique.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: dataGraphique.entries.map((e) {
                        return PieChartSectionData(
                          value: e.value,
                          title:
                              "${e.key}\n${e.value.toStringAsFixed(0)} ${userProvider.currencySymbole}",
                          radius: 60,
                          color: couleurCategorie(e.key),
                          titleStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

              SizedBox(height: screenHeigth * 0.020),

              Expanded(
                child: depenses.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Lottie.asset(
                              "animation/vide.json",
                              width: screenWith * 0.50,
                              height: screenHeigth * 0.25,
                              // width: 200,
                              //height: 200,
                              repeat: true,
                            ),
                            SizedBox(height: screenHeigth * 0.003),
                            Text(
                              "Acune dépenses actuellement",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenWith * 0.036,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: screenHeigth * 0.011),
                              itemCount: depenses.length,
                              itemBuilder: (context, index) {
                                final d = depenses[index];
                                String categorie = d['categorie'];
                                String note = d['note'];
                                final Timestamp timestamp = d['date'];
                                final DateTime date = timestamp.toDate();

                                Color bgIcon = BaktaCegoryStyle.getBackground(
                                  categorie,
                                );

                                IconData catIcon = BaktaCegoryStyle.getIcon(
                                  categorie,
                                );
                                Color iconColor = BaktaCegoryStyle.getIconColor(
                                  categorie,
                                );
                                return Container(
                                  width: double.infinity,
                                  height: screenHeigth * 0.11,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(screenWith * 0.034),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: screenHeigth * 0.052,
                                          width: screenWith * 0.11,
                                          decoration: BoxDecoration(
                                            color: bgIcon,
                                            borderRadius: BorderRadius.circular(
                                              screenWith * 0.034,
                                            ),
                                          ),
                                          child: Icon(
                                            catIcon,
                                            size: screenWith * 0.060,
                                            color: iconColor,
                                          ),
                                        ),

                                        SizedBox(width: screenWith * 0.028),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                categorie,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                note.isNotEmpty
                                                    ? note
                                                    : "aucune note",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),

                                              Text(
                                                formatDate(date),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Text(
                                          "${d['montant']} ${userProvider.currencySymbole}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
