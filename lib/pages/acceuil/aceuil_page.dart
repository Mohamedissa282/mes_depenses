import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/pages/acceuil/pages/page1.dart';
import 'package:mes_depenses/pages/acceuil/pages/page2.dart';
import 'package:mes_depenses/pages/authentification/connexion_inscription_page.dart';
import 'package:mes_depenses/services/notification_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AceuilPage extends StatefulWidget {
  const AceuilPage({super.key});

  @override
  State<AceuilPage> createState() => _AceuilPageState();
}

class _AceuilPageState extends State<AceuilPage> {
  final PageController controller = PageController();

  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              PageView(
                controller: controller,
                onPageChanged: (i) {
                  setState(() {
                    lastPage = (i == 1);
                  });
                },
                children: [Page1(), Page2()],
              ),

              Positioned(
                bottom: 120,
                left: 160,
                right: 160,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 2,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primaryLight,
                    dotColor: Colors.grey,
                  ),
                ),
              ),
              lastPage
                  ? Positioned(
                      bottom: 40,
                      left: 20,
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ConnexionInscriptionPage(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Commencer",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Positioned(
                      bottom: 40,
                      left: 20,
                      right: 20,
                      child: InkWell(
                        onTap: () async{
                         final ok = await NotificationService.demanderPermission();
    debugPrint("Permission accordée : $ok");
    await NotificationService.showBudgetNotification();
                          /*controller.nextPage(
                            duration: Duration(microseconds: 300),
                            curve: Curves.decelerate,
                          );*/
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Suivant",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
