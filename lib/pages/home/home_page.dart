import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as categorieBackground;
import 'package:lottie/lottie.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/color/categorie_color.dart';
import 'package:mes_depenses/provider/budget_provider.dart';
import 'package:mes_depenses/provider/user_provider.dart';
import 'package:mes_depenses/utils/date_formatter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final budgetProvider = Provider.of<Budgetprovider>(
        context,
        listen: false,
      );

      budgetProvider.chargerDepensesDuMois(
        userProvider.idUser,
        userProvider.budegtMax,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
     double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    final budgetProvider = Provider.of<Budgetprovider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final mois = DateFormat('MMMM yyyy', 'fr_FR').format(DateTime.now());
    final moisActuel =
        mois[0].toUpperCase() + mois.substring(1); // Octobre 2026
    return budgetProvider.isLoading
        ? Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 3,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWith * 0.026, vertical: screenHeigth * 0.022),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bonjour ${Provider.of<UserProvider>(context).nom}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWith * 0.047,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      moisActuel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWith * 0.063,
                      ),
                    ),

                    SizedBox(height: screenHeigth * 0.020),
                    Container(
                      width: double.infinity,
                      height: screenHeigth * 0.19,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(screenWith * 0.034),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reste sur ton budget",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWith * 0.042,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    budgetProvider.isHiden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                    size: 26,
                                  ),
                                  onPressed: () {
                                    budgetProvider.getHiden();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeigth * 0.001),
                            Text(
                              budgetProvider.isHiden
                                  ? "••••••"
                                  : "${budgetProvider.resteBudget} ${userProvider.currencySymbole}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWith * 0.059,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: screenHeigth * 0.024),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  budgetProvider.isHiden
                                      ? "••••••"
                                      : "Dépensé ${budgetProvider.totalDepense} ${userProvider.currencySymbole}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWith * 0.042,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  budgetProvider.isHiden
                                      ? "••••••"
                                      : "Budget ${userProvider.budegtMax} ${userProvider.currencySymbole}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWith * 0.042,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeigth * 0.048),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dernières dépenses",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWith * 0.036,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Tout voir",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWith * 0.036,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: budgetProvider.listDepenses.isEmpty
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
                              itemCount: budgetProvider.listDepenses.length,
                              itemBuilder: (context, index) {
                                final d = budgetProvider.listDepenses[index];
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
