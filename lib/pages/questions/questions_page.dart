import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/navigation/butom_navigation_bar.dart';
import 'package:mes_depenses/pages/questions/question1.dart';
import 'package:mes_depenses/pages/questions/question2.dart';
import 'package:mes_depenses/provider/monaie_budget.dart';
import 'package:mes_depenses/provider/user_provider.dart';
import 'package:mes_depenses/widget/myButon.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuestionsPage extends StatefulWidget {
  String uid;
  new({super.key, required this.uid});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  PageController controller = PageController();
  int index = 0;
  bool lastPage = false;

  bool isLoading = false;
  Future<void> enrgistrerInfo() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .update({
            "currencyCode": Provider.of<MonaieBudget>(
              context,
              listen: false,
            ).selectedCurrencyCode,
            "currencySymbole": Provider.of<MonaieBudget>(
              context,
              listen: false,
            ).selectedCurrencySymbol,
            "currencyName": Provider.of<MonaieBudget>(
              context,
              listen: false,
            ).selectedCurrencyName,
            "budgetMaxe": Provider.of<MonaieBudget>(
              context,
              listen: false,
            ).budegtMax,
          });
      setState(() {
        isLoading = false;
      });
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final monaieProvider = Provider.of<MonaieBudget>(context, listen: false);
      userProvider.setId(widget.uid);
      userProvider.setCurrency(
        monaieProvider.selectedCurrencyCode,
        monaieProvider.selectedCurrencyName,
        monaieProvider.selectedCurrencySymbol,
      );
      userProvider.setBudget(monaieProvider.budegtMax);
      

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ButomNavigationBarPage()),
      );
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.arrow_back),
                  ),

                  SmoothPageIndicator(
                    controller: controller,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primaryLight,
                      dotColor: Colors.grey,
                    ),
                  ),

                  Text(
                    "${index + 1}/2",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,

                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (i) {
                    setState(() {
                      lastPage = (i == 1);
                      index = i;
                    });
                  },
                  children: [Question1(), Question2()],
                ),
              ),

              lastPage
                  ? Mybuton(
                      child: isLoading
                          ? SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Terminer",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                      onTap: () {
                        enrgistrerInfo();
                      },
                    )
                  : Mybuton(
                      child: Text(
                        "Continuer",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      onTap: () {
                        if (Provider.of<MonaieBudget>(
                              context,
                              listen: false,
                            ).selectedCurrencyCode ==
                            "vide") {
                          print("is vide");
                        } else {
                          controller.nextPage(
                            duration: Duration(microseconds: 300),
                            curve: Curves.bounceIn,
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
