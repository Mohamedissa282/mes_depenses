import 'package:flutter/material.dart';

class MonaieBudget with ChangeNotifier {
  String selectedCurrencyCode = "vide";
  String selectedCurrencySymbol = "vide";
  String selectedCurrencyName = "vide";
  double budegtMax = 0.0;
  void addMonaie(String currencyCode, String symbole, String name) {
    selectedCurrencyCode = currencyCode;
    selectedCurrencySymbol = symbole;
    selectedCurrencyName = name;
    notifyListeners();
  }

  void addBudget(double budget) {
    budegtMax = budget;
    notifyListeners();
  }
}
