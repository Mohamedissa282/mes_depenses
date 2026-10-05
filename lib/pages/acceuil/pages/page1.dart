import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/pages/authentification/connexion_inscription_page.dart';

class Page1 extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PopupMenuButton(
                icon: Icon(Icons.language, color: Colors.black, size: 28),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {},
                    child: Text(
                      "Français",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {},
                    child: Text(
                      "Anglais",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ConnexionInscriptionPage(),
                            ),
                          );
                },
                child: Text(
                  "Passer",
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          Lottie.asset("animation/animation2.json"),
          Text(
            "Garde le contole de ton argent",
            style: TextStyle(
              fontSize: 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Note chaque dépense en quelques secondes et vois enfin ou par ton budget",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/*  













*/
