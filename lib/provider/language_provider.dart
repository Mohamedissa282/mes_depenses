import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = Locale("fr");

  Locale get local => _locale;

  void changeLangue(String codeLng) {
    _locale = Locale(codeLng);
    notifyListeners();
  }
}
