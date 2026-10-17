import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mes_depenses/color.dart';

class Page2 extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Lottie.asset("animation/animation1.json"),
          Text(
            "Visualise où va ton argent",
            style: TextStyle(
              fontSize: 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Découvre tes habitudes de consommation grâce à des statistiques simples et des graphiques clairs.",
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
