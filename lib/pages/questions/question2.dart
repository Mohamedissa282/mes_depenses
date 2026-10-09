import 'package:flutter/material.dart';
import 'package:mes_depenses/provider/monaie_budget.dart';
import 'package:provider/provider.dart';

class Question2 extends StatefulWidget {
  const new({super.key});

  @override
  State<Question2> createState() => _Question2State();
}

class _Question2State extends State<Question2> {
  TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MonaieBudget>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quelle est ton budget maximum par mois ?",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        SizedBox(height: 6),

        Text(
          "Tu pourras le modifier à tout moment.",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        SizedBox(height: 20),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Saiasir votre budget";
            }
          },
          controller: budgetController,
          onChanged: (value) {
            double budget = double.tryParse(value) ?? 0.0;
            userProvider.addBudget(budget);
          },
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "ton budget max",
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[400],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
