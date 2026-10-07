import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/provider/monaie_budget.dart';
import 'package:provider/provider.dart';

class Question1 extends StatefulWidget {
  const new({super.key});

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  String selectedCurrencyCode = "";
  String selectedCurrencySymbol = "";
  String selectedCurrencyName = "";
  bool isCustomCurrency = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFFD9EEE9),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Merci de répondre à ces questions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(height: 7),
                  Text(
                    "2 questions rapides, moins d'une minutes.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14),
          Text(
            "Quelle est ta monnaie principale ?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(height: 7),
          Text(
            "On l'utilisera pour tous tes montants.",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Column(
            children: [
              if (isCustomCurrency && selectedCurrencyCode.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.primaryLight, width: 1),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primaryLight,
                        child: Text(
                          selectedCurrencySymbol,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedCurrencyName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            selectedCurrencyCode,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.check_circle, color: Colors.white),
                    ],
                  ),
                ),

              currencyCard("€", "Euro", "EUR"),

              currencyCard("\$", "Dollar US", "USD"),

              InkWell(
                onTap: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) {
                      setState(() {
                        selectedCurrencyCode = currency.code;
                        selectedCurrencySymbol = currency.symbol;
                        selectedCurrencyName = currency.name;
                        isCustomCurrency = true;
                      });
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.language, color: AppColors.primaryLight),
                      SizedBox(width: 12),
                      Text(
                        "Changer de devise",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget currencyCard(String symbol, String name, String code) {
    bool isSelected = selectedCurrencyCode == code && !isCustomCurrency;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCurrencyCode = code;
          selectedCurrencySymbol = symbol;
          selectedCurrencyName = name;
          Provider.of<MonaieBudget>(context, listen: false).addMonaie(selectedCurrencyCode, selectedCurrencySymbol, selectedCurrencyName);
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primaryLight : Colors.grey.shade100,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected
                  ? AppColors.primaryLight
                  : Colors.grey.shade100,
              child: Text(
                symbol,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  code,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacer(),
            if (isSelected) Icon(Icons.check_circle, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
