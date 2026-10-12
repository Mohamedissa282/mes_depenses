import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  double totalMois = 0;

  @override
  void initState() {
    super.initState();
    chargerTousLesMois();
  }

 
  Future<void> chargerTousLesMois() async {
    setState(() => isLoding = true);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userProvider.idUser)
        .collection("expenses")
        .orderBy("date", descending: true)
        .get();

    final Set<String> mois = {};
    for (var doc in snapshot.docs) {
      mois.add("${doc['mois']} ${doc['annee']}");
    }

    setState(() {
      moisList = mois.toList();
      if (moisList.isNotEmpty) {
        moisSelectionne = moisList.first;
      }
      isLoding = false;
    });

    if (moisSelectionne.isNotEmpty) {
      chargerDepensesDuMois(moisSelectionne);
    }
  }

  // Charger les dépenses du mois sélectionné
  Future<void> chargerDepensesDuMois(String mois) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final parts = mois.split(" ");
    final moisTexte = parts[0];
    final annee = int.parse(parts[1]);

    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userProvider.idUser)
        .collection("expenses")
        .where("mois", isEqualTo: moisTexte)
        .where("annee", isEqualTo: annee)
        .get();

    // Tri par date, du plus récent au plus ancien
    final docs = snapshot.docs.toList();
    docs.sort((a, b) {
      final dateA = (a['date'] as Timestamp).toDate();
      final dateB = (b['date'] as Timestamp).toDate();
      return dateB.compareTo(dateA);
    });

    setState(() {
      depenses = docs;
    });

    calculerGraphique();
  }

  // Calculer les montants par catégorie + total
  void calculerGraphique() {
    final Map<String, double> categories = {};
    double total = 0;

    for (var d in depenses) {
      final cat = (d['categorie'] ?? "Autres").toString();
      final montant = (d['montant'] as num).toDouble();

      categories[cat] = (categories[cat] ?? 0) + montant;
      total += montant;
    }

    setState(() {
      dataGraphique = categories;
      totalMois = total;
    });
  }

  // Couleurs par catégorie
  Color couleurCategorie(String cat) {
    switch (cat.toLowerCase()) {
      case "restaurant":
        return const Color(0xFFFFA726);
      case "transport":
        return const Color(0xFF29B6F6);
      case "santé":
        return const Color(0xFFE53935);
      case "sport":
        return const Color(0xFF43A047);
      case "études":
        return const Color(0xFF7E57C2);
      case "sorties":
        return const Color(0xFFEC407A);
      case "autres":
        return const Color(0xFFBDBDBD);
      default:
        return Colors.grey;
    }
  }

  // 14.5 -> "14,50" ; 680 -> "680"
  String formatMontant(double v) {
    if (v == v.roundToDouble()) return v.toStringAsFixed(0);
    return v.toStringAsFixed(2).replaceAll('.', ',');
  }

  // Carte "Total dépensé" avec barre segmentée
  Widget carteTotal(
    double screenWith,
    double screenHeigth,
    String devise,
  ) {
    final entries = dataGraphique.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWith * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWith * 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Total dépensé",
                style: TextStyle(
                  fontSize: screenWith * 0.036,
                  color: Colors.black54, fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "${formatMontant(totalMois)} $devise",
                style: TextStyle(
                  fontSize: screenWith * 0.070,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeigth * 0.012),

          // BARRE SEGMENTÉE
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 8,
              child: Row(
                children: [
                  for (int i = 0; i < entries.length; i++) ...[
                    Expanded(
                      flex: totalMois == 0
                          ? 1
                          : ((entries[i].value / totalMois) * 1000)
                              .round()
                              .clamp(1, 1000),
                      child: Container(
                        color: couleurCategorie(entries[i].key),
                      ),
                    ),
                    if (i < entries.length - 1) const SizedBox(width: 2),
                  ],
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeigth * 0.012),

          // LÉGENDE
          Wrap(
            spacing: screenWith * 0.04,
            runSpacing: 4,
            children: entries.map((e) {
              return Text(
                "${e.key} ${formatMontant(e.value)} $devise",
                style: TextStyle(
                  fontSize: screenWith * 0.03,
                  fontWeight: FontWeight.bold,
                  color: couleurCategorie(e.key),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String devise = userProvider.currencySymbole;
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWith * 0.035,
            vertical: screenHeigth * 0.024,
          ),
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

              // LISTE DES MOIS
              isLoding
                  ? const Align(
                      alignment: Alignment.center,
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
                              setState(() => moisSelectionne = m);
                              chargerDepensesDuMois(m);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: screenWith * 0.010,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWith * 0.04,
                                vertical: screenHeigth * 0.011,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.circular(screenWith * 0.058),
                              ),
                              child: Text(
                                m,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

              SizedBox(height: screenHeigth * 0.023),

              // CARTE TOTAL + BARRE SEGMENTÉE
              if (dataGraphique.isNotEmpty)
                carteTotal(screenWith, screenHeigth, devise),

              SizedBox(height: screenHeigth * 0.015),

              // LISTE DES DÉPENSES (plus récent en premier, comme la page home)
              Expanded(
                child: depenses.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Lottie.asset(
                              "animation/vide.json",
                              width: screenWith * 0.50,
                              height: screenHeigth * 0.25,
                              repeat: true,
                            ),
                            SizedBox(height: screenHeigth * 0.003),
                            Text(
                              "Aucune historique actuellement",
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
                              borderRadius:
                                  BorderRadius.circular(screenWith * 0.034),
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
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          note.isNotEmpty
                                              ? note
                                              : "aucune note",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          formatDate(date),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Text(
                                    "${d['montant']} $devise",
                                    style: const TextStyle(
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