import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_e_commerce/app/my_app.dart';
import 'package:simple_e_commerce/app/my_app_controller.dart';
import 'package:simple_e_commerce/core/data/repositories/storage_repositories.dart';
import 'package:simple_e_commerce/core/services/background_message_handler_service.dart';
import 'package:simple_e_commerce/core/services/connectivity_service.dart';
import 'package:simple_e_commerce/core/services/notification_service.dart';
import 'package:simple_e_commerce/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  MessageNewProduct.showInOutApp(message: message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      defaultColor: Colors.blue,
      importance: NotificationImportance.High,
      channelDescription: 'ssss',
    ),
  ], debug: true);
  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  await initApp();
  Get.put(SharedPreferenceRepositories());
  Get.put(ConnectivityService());
  Get.put(MyAppController());
  runApp(const MyApp());
}

Future<void> initApp() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Get.put(NotificationService());
  } catch (e) {
    (e);
  }
  await Get.putAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });
}
