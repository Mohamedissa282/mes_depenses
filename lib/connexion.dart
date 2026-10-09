import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TestGraphique extends StatelessWidget {
  const TestGraphique({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemple de données (tu vas remplacer ça par tes vraies données)
    final Map<String, double> dataGraphique = {
      "Restaurant": 120,
      "Transport": 80,
      "Santé": 40,
      "Études": 60,
      "Sorties": 30,
    };

    return Scaffold(
      appBar: AppBar(title: const Text("Test Graphique")),
      body: Center(
        child: PieChart(
          PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: 40,
            sections: dataGraphique.entries.map((e) {
              return PieChartSectionData(
                value: e.value,
                title: "${e.key}\n${e.value.toStringAsFixed(0)}€",
                radius: 60,
                titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                color: _couleurCategorie(e.key),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Couleurs par catégorie
  Color _couleurCategorie(String cat) {
    switch (cat) {
      case "Restaurant":
        return Colors.orange;
      case "Transport":
        return Colors.green;
      case "Santé":
        return Colors.red;
      case "Études":
        return Colors.blue;
      case "Sorties":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
