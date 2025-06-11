import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/app/my_app.dart';
import 'package:simple_e_commerce/app/my_app_controller.dart';
import 'package:simple_e_commerce/core/services/background_message_handler_service.dart';
import 'package:simple_e_commerce/core/services/connectivity_service.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart' as di;

@pragma('vm:entry-point')
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  MessageNewProduct.showInOutApp(message: message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize GetIt Service Locator

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
  await initApp(); // initApp might have Get.put calls, ensure DI is ready
  // Get.put(SharedPreferenceRepositories());
  Get.put(ConnectivityService());
  Get.put(MyAppController());
  runApp(const MyApp());
}

Future<void> initApp() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);


}
