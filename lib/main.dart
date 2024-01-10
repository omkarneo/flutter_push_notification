import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/firebase_options.dart';
import 'package:flutter_push_notification/localnotification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    localNotificationService.initialize();
    firebaseApiInit();
  }

  void firebaseApiInit() async {
    FirebaseMessaging.onMessage.listen((event) {
      var data = jsonDecode(event.data['payload']);
      localNotificationService.showLocalNotification(
          data['title'], data['body']);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      var data = jsonDecode(event.data['payload']);
      // print(jsonDecode(event.data['payload'])['title']);
      localNotificationService.showLocalNotification(
          data['title'], data['body']);
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      print(message);
    });
  }

  String deviceFcm = "";
  TextEditingController fcmtokeeninput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final fcmToken =
                        await FirebaseMessaging.instance.getToken();
                    print(fcmToken);
                    setState(() {
                      deviceFcm = fcmToken ?? "";
                    });
                  },
                  child: const Text("Click here to Create FCM TOken")),
            ],
          ),
        ),
      ),
    );
  }
}
