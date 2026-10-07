import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const new({super.key});

  @override
  State<ProfilPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profil",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Text(
                      "MI",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    Provider.of<UserProvider>(context).nom,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  subtitle: Text(
                    Provider.of<UserProvider>(context).email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "MONNAIE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Text(
                          userProvider.currencySymbole,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        userProvider.currencyName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      subtitle: Text(
                        "Monnaie principale",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  
                
              ),
            SizedBox(height: 15),
              Text(
                "PREFERNCES",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 15),

              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(0xFFD9EEE9),
                                child: Icon(Icons.notifications_outlined,color: Color(0xFF0B6B5D),)
                              ),
                              title: Text(
                                "Notifications",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                        
                              subtitle: Text(
                                "Alerte si tu dépasse ton budget",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 12
                                ),
                              ),
                              trailing: Switch(
                                activeThumbColor: Colors.white,
                               activeTrackColor: AppColors.primaryLight,
                               
                                value: true, onChanged: (val){}
                                
                                ),
                            ),
                                    
                            Divider(),
                    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Row(children: [
                                CircleAvatar(
                                backgroundColor: Color(0xFFD9EEE9),
                                child: Icon(Icons.language,color: Color(0xFF0B6B5D),)
                              ),
                    SizedBox(width: 9),
                              Text(
                                "Langue",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              ],),
                    
                              Row(children: [
                                Text(
                                "Français",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(onPressed: (){

                              }, icon: Icon(Icons.chevron_right))
                              ],)
                            ],)
                      ],
                    ),
                  ),
                    
                  
                ),
              ),
              SizedBox(height: 14,),
              InkWell(
                onTap: () {
                  print(
                    Provider.of<UserProvider>(
                      context,
                      listen: false,
                    ).currencyCode,
                  );
                  print(
                    Provider.of<UserProvider>(
                      context,
                      listen: false,
                    ).currencyName,
                  );
                  print(
                    Provider.of<UserProvider>(
                      context,
                      listen: false,
                    ).currencySymbole,
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 55),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: Colors.redAccent, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 7),
                      Text(
                        "Se déconnecter",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  "Mes dépenses",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
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
