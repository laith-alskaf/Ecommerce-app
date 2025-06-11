import 'dart:convert';
import 'dart:math' as math;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/product_details_view/product_details_view.dart';
import 'package:simple_e_commerce/presentation/widgets/notification_snack.dart';

abstract class MessageHandlerNotification {
  void showInApp({required RemoteMessage message});

  void onMessageOpenedOutApp({required String body});

  @pragma('vm:entry-point')
  static void showInOutApp({required RemoteMessage message}) {}
}

class MessageNewProduct extends MessageHandlerNotification {
  MessageNewProduct._privateConstructor();

  static final MessageNewProduct _instance =
      MessageNewProduct._privateConstructor();

  static MessageNewProduct get instance => _instance;

  @override
  void showInApp({required RemoteMessage message}) {
    Map<String, dynamic> jsonMap = jsonDecode(message.data['body']);
    ProductModel product = ProductModel.fromJson(jsonMap);
    showNotificationSnack(
      title: message.data['title'] ?? 'Notification',
      body: product.description ?? 'You have a new message.',
      buttonHandler: () {
        Get.closeAllSnackbars();
        Get.to(() => ProductDetailsView(productDetails: product));
      },
      buttonText: "Open",
    );
  }

  @override
  void onMessageOpenedOutApp({required String body}) async {
    Map<String, dynamic> jsonMap = jsonDecode(body);
    ProductModel product = ProductModel.fromJson(jsonMap);
    Get.to(ProductDetailsView(productDetails: product));
  }

  @pragma('vm:entry-point')
  static void showInOutApp({required RemoteMessage message}) async {
    Map<String, dynamic> jsonMap = jsonDecode(message.data['body']);
    ProductModel product = ProductModel.fromJson(jsonMap);
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: math.Random().nextInt(999999),
        channelKey: 'basic_channel',
        title: product.title ?? 'Notification',
        body: product.description ?? 'You have a new message.',
        payload: {'product': message.data['body']},
        largeIcon: product.images![0],
        notificationLayout: NotificationLayout.BigPicture,
        color: Color(0xFF00FF00),
        wakeUpScreen: true,
      ),
    );
  }
}
