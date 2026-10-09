import 'package:flutter/material.dart';

class BaktaCegoryStyle {
  static Color getBackground(String categorie) {
    switch (categorie.toLowerCase()) {
      case "restaurant":
        return const Color(0xFFFDE7CF); // orange clair
      case "transport":
        return const Color(0xFFE0ECFF); // bleu clair
      case "santé":
        return const Color(0xFFFFE0E0); // rouge clair
      case "sport":
        return const Color(0xFFE3F8E6); // vert clair
      case "études":
        return const Color(0xFFF0E8FF); // violet clair
      case "sorties":
        return const Color(0xFFFFE4EE); // rose clair
      case "autres":
        return const Color(0xFFE4F7ED); // vert foncé clair
      default:
        return const Color(0xFFE5E7EB); // gris clair
    }
  }

  static IconData getIcon(String categorie) {
    switch (categorie.toLowerCase()) {
      case "restaurant":
        return Icons.restaurant;
      case "transport":
        return Icons.directions_bus;
      case "santé":
        return Icons.health_and_safety;
      case "sport":
        return Icons.sports_soccer;
      case "études":
        return Icons.school;
      case "sorties":
        return Icons.local_bar;
      case "autres":
        return Icons.shopping_cart;
      default:
        return Icons.category;
    }
  }

  static Color getIconColor(String categorie){
    switch (categorie.toLowerCase()){
     case "restaurant":
        return const Color(0xFFB45309); 
      case "transport":
        return const Color(0xFF2563EB); 
      case "santé":
        return const Color(0xFFDC2626); 
      case "sport":
        return const Color(0xFF16A34A); 
      case "études":
        return const Color(0xFF7C3AED); 
      case "sorties":
        return const Color(0xFFE11D48); 
      case "autres":
        return const Color(0xFF059669); 
      default:
        return const Color(0xFF6B7280); 
    }
  }
}
