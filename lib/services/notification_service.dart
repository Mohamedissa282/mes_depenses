import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Nom de l'icône : android/app/src/main/res/drawable/logo.png
  // (sans extension, minuscules uniquement)
  static const String _icone = 'logo';

  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(_icone);

    const settings = InitializationSettings(
      android: androidSettings,
    );

    await notificationsPlugin.initialize(
      settings: settings,
    );
  }

  // À appeler quand l'utilisateur active le switch
  static Future<bool> demanderPermission() async {
    final android = notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    return await android?.requestNotificationsPermission() ?? false;
  }

  static Future<void> showBudgetNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'budget_channel',
      'Budget Notifications',
      channelDescription: 'Notification de budget',
      importance: Importance.max,
      priority: Priority.high,
      icon: _icone, // même nom que dans init()
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.show(
      id: 0,
      title: 'Budget dépassé',
      body: 'Vous avez dépassé votre budget mensuel.',
      notificationDetails: notificationDetails,
    );
  }

  static Future<void> show80BudgetNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'budget_channel',
      'Budget Notifications',
      channelDescription: 'Notification de budget',
      importance: Importance.max,
      priority: Priority.high,
      icon: _icone, 
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.show(
      id: 0,
      title: 'Attention à votre budget',
      body: 'Vous avez déjà utilisé 80 % de votre budget mensuel.',
      notificationDetails: notificationDetails,
    );
  }
}