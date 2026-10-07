import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _nom = "";
  String _email = "";
  String _currencyCode = "";
  String _currencySymbole = "";
  String _currencyName = "";

  double _budgetMax = 0.0;
  String _idUser = "";
  String get nom => _nom;
  String get email => _email;
  String get currencyCode => _currencyCode;
  String get currencySymbole => _currencySymbole;
  String get currencyName => _currencyName;
  String get idUser => _idUser;
  double get budegtMax => _budgetMax;
  void setName(String nom) {
    _nom = nom;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setCurrency(String code, String name, String symbole) {
    _currencyCode = code;
    _currencyName = name;
    _currencySymbole = symbole;
    notifyListeners();
  }

  void setBudget(double number) {
    _budgetMax = number;
    notifyListeners();
  }

  void setId(String id) {
    _idUser = id;
    notifyListeners();
  }
}
