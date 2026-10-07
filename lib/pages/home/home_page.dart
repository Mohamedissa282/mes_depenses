import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/provider/budget_provider.dart';
import 'package:mes_depenses/provider/user_provider.dart';
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bonjour ${Provider.of<UserProvider>(context).nom}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      moisActuel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),

                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      height: 155,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14),
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
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    budgetProvider.isHiden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey, size: 26,
                                  ),
                                  onPressed: () {
                                    budgetProvider.getHiden();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Text(
                              budgetProvider.isHiden ? "••••••" :
                              "${budgetProvider.resteBudget} ${userProvider.currencySymbole}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  budgetProvider.isHiden ? "••••••" :
                                  "Dépensé ${budgetProvider.totalDepense} ${userProvider.currencySymbole}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  budgetProvider.isHiden ? "••••••" :
                                  "Budget ${userProvider.budegtMax} ${userProvider.currencySymbole}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dernières dépenses",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Tout voir",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
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
                                    width: 200,
                                    height: 200,
                                    repeat: true,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Acune dépenses actuellement",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 9),
                              itemCount: budgetProvider.listDepenses.length,
                              itemBuilder: (context, index) {
                                final d = budgetProvider.listDepenses[index];
                                return Container(
                                  width: double.infinity,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                  ),

                                  child: ListTile(
                                    title: Text(
                                      d['note'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      d['categorie'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    trailing: Text(
                                      "${d['montant']} ${userProvider.currencySymbole}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),

                                    leading: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFDE7CF),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Icon(
                                        Icons.restaurant,
                                        size: 20,
                                        color: Color(0xFFB45309),
                                      ),
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
