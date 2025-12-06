import 'dart:async';
import 'dart:convert';

import 'package:chipmunk/src/core/permission/permission.dart';
import 'package:chipmunk/src/core/storage/storage.dart';
import 'package:chipmunk/src/presentation/pages/login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
   _initService();
  runApp(const MyApp());
  // fetchUsers();
}

Future<void> _initService() async{
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   GetStorage.init();
   await requestNotificationPermission();

  // Initialize Firebase

  // Initialize local notifications
  await initNotifications();

  // Request permissions

  // Set background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

  // Listen foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("🔔 Foreground message: ${message.notification?.title}");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon,
          ),
          iOS: DarwinNotificationDetails(),
        ),
      );
    }
  });

  // Listen token refresh
  FirebaseMessaging.instance.onTokenRefresh.listen((token) {
    print("FCM token refreshed: $token");
  });

  // Get current token
  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM token: $token");

}

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  // In dữ liệu nhận được
  print("🔔 Background Message: ${message.data}");

  // Init GetStorage cho isolate nền
  await GetStorage.init();


  // fetchUsers();
  Timer.periodic(const Duration(seconds: 1), (timer) {
    // Lấy thời gian hiện tại
    final now = DateTime.now();

    // Format hh:mm:ss
    final formatted = DateFormat('HH:mm:ss').format(now);
    print("Log mỗi giây: ${formatted}");
  });

  // print("🔔 Background Message 2: ${formatted}");
}

Future<void> fetchUsers() async {
  final url = Uri.parse('https://dummyjson.com/users');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonEncode(response.body);
    print('Users data: $data');
    // Lưu vào Storage
    Storage.instance.setString("date", data);
  } else {
    print('Request failed with status: ${response.statusCode}');
    Storage.instance.setString("date", "error");
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '123123',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    ),
    home: SafeArea(child: const LoginPage(title:"   FlutterDemoHomePage"
    )
    )
    );
  }
}
