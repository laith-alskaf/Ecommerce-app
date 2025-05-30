import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/enums/connectivity_status.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/core/services/notification_controller.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/firebase_options.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/notification_snack.dart';
import 'dart:math' as math;

class MyAppController extends BaseController {
  ConnectivityStatus connectivityStatus = ConnectivityStatus.ONLINE;
  RxBool isOnline = false.obs;

  set setConnectivityStatus(ConnectivityStatus value) {
    connectivityStatus = value;
  }

  void listenForConnectivityStatus() {
    ("Connection From MyAppController First initial $connectivityStatus");
    connectivityService.connectivityStatusController.stream.listen((event) {
      setConnectivityStatus = event;
      ("Connection From MyAppController Changed To $event");
      myAppController.isOnline.value =
          connectivityStatus == ConnectivityStatus.ONLINE ? true : false;
    });
  }

  void initMyServices() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> subscribeToTopicNewProduct() async {
    await FirebaseMessaging.instance.subscribeToTopic('new_product');
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    Get.put(NotificationController());
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        Map<String, dynamic> jsonMap = jsonDecode(notification.body!);
        ProductModel product = ProductModel.fromJson(jsonMap);
        showNotificationSnack(
          notification.title!,
          product.description!,
          buttonHandler: () {},
          buttonText: "Open",
        );
      }
    });
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  @pragma("vm:entry-point")
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      Map<String, dynamic> jsonMap = jsonDecode(notification.body!);
      ProductModel product = ProductModel.fromJson(jsonMap);
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: math.Random().nextInt(999999),
          channelKey: 'basic_channel',
          title: product.title ?? '',
          body: product.description ?? '',
        ),
      );
    }

  }

  @override
  void onInit() async {
    super.onInit();
    listenForConnectivityStatus();
    initMyServices();
  }
}
