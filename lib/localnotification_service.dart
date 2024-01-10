import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class localNotificationService {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void initialize() {
    // Initialization  setting for android
    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
            android: AndroidInitializationSettings("@drawable/ic_launcher"));
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

  static showLocalNotification(String title, String body) {
    const androidNotificationDetail = AndroidNotificationDetails(
        'demo_app', // channel Id
        'demo_app' // channel Name
        );
    const iosNotificatonDetail = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      iOS: iosNotificatonDetail,
      android: androidNotificationDetail,
    );
    _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }
}
