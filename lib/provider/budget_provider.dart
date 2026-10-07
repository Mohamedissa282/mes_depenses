import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Budgetprovider with ChangeNotifier {
  double _resteBudget = 0.0;
  double _totalDepense = 0.0;
  List<QueryDocumentSnapshot> _depensesDuMois = [];

  double get resteBudget => _resteBudget;
  double get totalDepense => _totalDepense;
  List<QueryDocumentSnapshot> get listDepenses => _depensesDuMois;

  Future<void> chargerDepensesDuMois(String uid, double budgetMax) async {
    DateTime now = DateTime.now();
    String moisActuel = DateFormat('MMMM', 'fr_FR').format(now).toLowerCase();
    int anneeActuelle = now.year;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("expenses")
        .where("mois", isEqualTo: moisActuel)
        .where("annee", isEqualTo: anneeActuelle)
        .get();

    _depensesDuMois = snapshot.docs;

    _totalDepense = 0.0;
    for (var doc in snapshot.docs) {
      _totalDepense += (doc['montant'] as num).toDouble();
    }

    _resteBudget = budgetMax - _totalDepense;

    notifyListeners();
  }
}

