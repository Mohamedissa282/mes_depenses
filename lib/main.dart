import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:mes_depenses/firebase_options.dart';
import 'package:mes_depenses/navigation/butom_navigation_bar.dart';
import 'package:mes_depenses/pages/acceuil/aceuil_page.dart';
import 'package:mes_depenses/pages/acceuil/pages/page1.dart';
import 'package:mes_depenses/pages/authentification/connexion_inscription_page.dart';
import 'package:mes_depenses/pages/questions/questions_page.dart';
import 'package:mes_depenses/pages/home/home_page.dart';
import 'package:mes_depenses/provider/budget_provider.dart';
import 'package:mes_depenses/provider/language_provider.dart';
import 'package:mes_depenses/provider/monaie_budget.dart';
import 'package:mes_depenses/provider/user_provider.dart';
import 'package:mes_depenses/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  await NotificationService.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MonaieBudget()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => Budgetprovider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Provider.of<LanguageProvider>(context).local,

      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: ConnexionInscriptionPage(),
    );
  }
}
