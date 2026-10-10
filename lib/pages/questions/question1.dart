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
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.all(screenWith * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeigth * 0.089,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWith * 0.026),
              color: Color(0xFFD9EEE9),
            ),
            child: Padding(
              padding:  EdgeInsets.all(screenWith * 0.020),
              child: Column(
                children: [
                  Text(
                    "Merci de répondre à ces questions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWith * 0.043),
                  ),
                  SizedBox(height: screenHeigth * 0.009),
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
          SizedBox(height: screenHeigth * 0.017),
          Text(
            "Quelle est ta monnaie principale ?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWith * 0.044),
          ),
          SizedBox(height: screenHeigth * 0.009),
          Text(
            "On l'utilisera pour tous tes montants.",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(height: screenHeigth * 0.021),
          Column(
            children: [
              if (isCustomCurrency && selectedCurrencyCode.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(screenWith * 0.036),
                  margin: EdgeInsets.only(bottom: screenHeigth * 0.015),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(screenWith * 0.036),
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
                            fontSize: screenWith * 0.055,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWith * 0.033),
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
                  padding: EdgeInsets.all(screenWith * 0.039),
                  margin: EdgeInsets.only(top: screenHeigth * 0.010),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWith * 0.034),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.language, color: AppColors.primaryLight),
                      SizedBox(width: screenWith * 0.033),
                      Text(
                        "Changer de devise",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: screenWith * 0.054,
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
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
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
        padding: EdgeInsets.all(screenWith * 0.036),
        margin: EdgeInsets.only(bottom: screenHeigth * 0.015),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(screenWith * 0.036),
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
                  fontSize: screenWith * 0.055,
                ),
              ),
            ),
            SizedBox(width: screenWith * 0.033),
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
