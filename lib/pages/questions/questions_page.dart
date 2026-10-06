import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/navigation/butom_navigation_bar.dart';
import 'package:mes_depenses/pages/questions/question1.dart';
import 'package:mes_depenses/pages/questions/question2.dart';
import 'package:mes_depenses/widget/myButon.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuestionsPage extends StatefulWidget {
  const new({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  PageController controller = PageController();
  int index = 0;
  bool lastPage = false;
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
                      text: "Terminer",
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          (MaterialPageRoute(
                            builder: (context) => ButomNavigationBarPage(),
                          )),
                        );
                      },
                    )
                  : Mybuton(
                      text: "Continuer",
                      onTap: () {
                        controller.nextPage(
                          duration: Duration(microseconds: 300),
                          curve: Curves.bounceIn,
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
