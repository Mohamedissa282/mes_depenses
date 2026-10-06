import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';

class HistoriquePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  int selected = -1;
  int selectedFixe = 3;
  List mois = ["Juin", "Juillet", "Aout", "Sept."];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Historique",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 14),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  itemCount: 4,
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // bool isSelected = selected == index;
                    bool isSelected = selectedFixe == index;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedFixe = 3;
                        });
                      },
                      child: Container(
                        width: 70,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            mois[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 40),
              Text(
                "2 Octobre",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),

                child: ListTile(
                  title: Text(
                    "Déjeuner",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    "Restaurant",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  trailing: Text(
                    "-14,50 MRU",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),

                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFDE7CF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      size: 20,
                      color: Color(0xFFB45309),
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
