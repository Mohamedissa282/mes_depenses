import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Bonjour", style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 17, color: Colors.grey
                ),),
                Text("Octobre 2026", style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25
                ),),
          
                
              ],),
          
              Container(
                height: 40, width: 40,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(14)
                ),
                child: Icon(Icons.calendar_today_outlined, size: 20,),
              )
            ],),
            SizedBox(height: 15,),
            Container(
              width: double.infinity,
              height: 155,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14)
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Reste sur ton budget", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white
                  ),),
                SizedBox(height: 5,),
                  Text("320 MRU", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white
                  ),),
                SizedBox(height: 44,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Dépensé 680 MRU", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white
                  ),),
                  Text("Budget 1000 MRU", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white
                  ),),
                  ],)
                ],),
              ),
            ),

           SizedBox(height: 45,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Text("Dernières dépenses", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black
                  ),),
                  TextButton(onPressed: (){

                  }, child: Text("Tout voir", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primary
                  ),),)
                  
            ],),
           
           Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14)
              ),

              child: ListTile(
                title: Text("Déjeuner", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black
                  ),),
              subtitle: Text("Restaurant. 2 oct.", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey
                  ),),

                  trailing:Text("-14,50 MRU", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black
                  ),),

              leading:  Container(
                height: 40, width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFDE7CF), 
                  borderRadius: BorderRadius.circular(14)
                ),
                child: Icon(Icons.restaurant, size: 20, color: Color(0xFFB45309),),
              ),
              )
              
           ),
         SizedBox(height: 12,),
            Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14)
              ),

              child: ListTile(
                title: Text("Déjeuner", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black
                  ),),
              subtitle: Text("Restaurant. 2 oct.", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey
                  ),),

                  trailing:Text("-14,50 MRU", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black
                  ),),

              leading:  Container(
                height: 40, width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFDCE8FB), 
                  borderRadius: BorderRadius.circular(14)
                ),
                child: Icon(Icons.menu_book_outlined, size: 20, color: Color(0xFF1D4ED8),),
              ),
              )
              
           ),
      SizedBox(height: 12,),
            Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14)
              ),

              child: ListTile(
                title: Text("Déjeuner", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black
                  ),),
              subtitle: Text("Restaurant. 2 oct.", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey
                  ),),

                  trailing:Text("-14,50 MRU", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black
                  ),),

              leading:  Container(
                height: 40, width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFEADCF8	), 
                  borderRadius: BorderRadius.circular(14)
                ),
                child: Icon(Icons.confirmation_number_outlined, size: 20, color: Color(0xFF6D28D9),),
              ),
              )
              
           )

          ],),
        ),
      ),
    );
  }
}