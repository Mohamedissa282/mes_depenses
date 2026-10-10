import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mes_depenses/color.dart';
import 'package:mes_depenses/generated/l10n.dart';
import 'package:mes_depenses/pages/authentification/connexion_inscription_page.dart';
import 'package:mes_depenses/pages/setting/modifier_profil_page.dart';
import 'package:mes_depenses/provider/language_provider.dart';
import 'package:mes_depenses/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const new({super.key});

  @override
  State<ProfilPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<ProfilPage> {
  bool isActive = false;
  void afficherChoixLangue() {
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    final langueProvider = Provider.of<LanguageProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Langue",
                style: TextStyle(
                  fontSize: screenWith * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //  SizedBox(height:screenHeigth * 0.045),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  "Francais",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: langueProvider.local.languageCode =="fr" ? Icon(Icons.check, color: Colors.green) : null,

                onTap: () {
                  langueProvider.changeLangue("fr");
                },
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  "Anglais",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: langueProvider.local.languageCode == "en" ? Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  langueProvider.changeLangue("en");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWith = MediaQuery.of(context).size.width;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenWith * 0.042,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Profil"
                  Text(
                    S.of(context).title1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWith * 0.055,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // CARTE PROFIL
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Text(
                          userProvider.nom.isNotEmpty
                              ? userProvider.nom[0].toUpperCase()
                              : "?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: screenWith * 0.053,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ModifierProfilPage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit, size: screenWith * 0.053),
                      ),
                      title: Text(
                        userProvider.nom,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: screenWith * 0.046,
                        ),
                      ),
                      subtitle: Text(
                        userProvider.email,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // MONNAIE
                  Text(
                    "MONNAIE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWith * 0.039,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Text(
                          userProvider.currencySymbole,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        userProvider.currencyName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: const Text(
                        "Monnaie principale",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // PRÉFÉRENCES
                  Text(
                    "PRÉFÉRENCES",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWith * 0.039,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // CARTE DES PRÉFÉRENCES
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // NOTIFICATIONS
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFD9EEE9),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Color(0xFF0B6B5D),
                            ),
                          ),
                          title: const Text(
                            "Notifications",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            "Alerte si tu dépasses ton budget",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: screenWith * 0.031,
                            ),
                          ),
                          trailing: Switch(
                            activeThumbColor: Colors.white,
                            activeTrackColor: AppColors.primaryLight,
                            value: isActive,
                            onChanged: (val) {
                              setState(() {
                                isActive = val;
                              });
                            },
                          ),
                        ),

                        Divider(height: 1, indent: 16, endIndent: 16),

                        // LANGUE
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFFD9EEE9),
                            child: Icon(
                              Icons.language,
                              color: Color(0xFF0B6B5D),
                            ),
                          ),
                          title: Text(
                            "Langue",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              afficherChoixLangue();
                            },
                            child: Text(
                              "Français",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: screenWith * 0.037,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // DÉCONNEXION
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();

                        if (!context.mounted) return;

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => ConnexionInscriptionPage(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.logout, color: Colors.redAccent),
                      label: const Text(
                        "Se déconnecter",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.redAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // INFORMATIONS DE L'APPLICATION
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Mes Dépenses",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: screenWith * 0.041,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Version 1.0.0",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
