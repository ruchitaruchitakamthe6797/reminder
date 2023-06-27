import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:send_remider_to_user/data/api/firebase_api.dart';
import 'package:send_remider_to_user/firebase_options.dart';
import 'package:send_remider_to_user/ui/contacts/contacts.dart';
import 'package:send_remider_to_user/ui/my_app.dart';

import 'di/components/service_locator.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await setPreferredOrientations();
  await setupLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(RelationshipAdapter());
  await Hive.openBox<Contact>(contactsBoxName);
  // runApp(MyApp1());
  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    log(stack.toString());
    log(error.toString());
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
// void main() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(ContactAdapter());
//   Hive.registerAdapter(RelationshipAdapter());
//   await Hive.openBox<Contact>(contactsBoxName);
//   runApp(MyApp1());
// }
