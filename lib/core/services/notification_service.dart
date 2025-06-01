import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart' as hand;
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_e_commerce/core/services/background_message_handler_service.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';

class NotificationService {
  @override
  NotificationService() {
    initNotification();
  }

  // Future<void> onInit() async {
  //   AwesomeNotifications().initialize(
  //     // set the icon to null if you want to use the default app icon
  //     'resource://drawable/res_notification_icon',
  //     [
  //       NotificationChannel(
  //         channelGroupKey: 'basic_channel_group',
  //         channelKey: 'basic_channel',
  //         channelName: 'Basic notifications',
  //         channelDescription: 'Notification channel for payments',
  //         defaultColor: AppColors.mainColor,
  //         ledColor: AppColors.whiteColor,
  //         importance: NotificationImportance.Max,
  //         playSound: true,
  //       ),
  //     ],
  //     // Channel groups are only visual and are not required
  //     channelGroups: [
  //       NotificationChannelGroup(
  //         channelGroupKey: 'basic_channel_group',
  //         channelGroupName: 'Basic group',
  //       ),
  //     ],
  //     debug: true,
  //   );
  //   AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
  //     if (!isAllowed) {
  //       await isPermissionGranted();
  //
  //       AwesomeNotifications().requestPermissionToSendNotifications();
  //     }
  //   });
  //   AwesomeNotifications().setListeners(
  //     onActionReceivedMethod: onActionReceivedMethod,
  //     onNotificationCreatedMethod: onNotificationCreatedMethod,
  //     onNotificationDisplayedMethod: onNotificationDisplayedMethod,
  //     onDismissActionReceivedMethod: onDismissActionReceivedMethod,
  //   );
  // }
  initNotification() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await isPermissionGranted();

        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // save incoming notification
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    print('22222222222222222222222');
    print(receivedAction.body);
    MessageNewProduct.instance.onMessageOpenedOutApp(
      body: receivedAction.payload?['product'] ?? '',
    );
  }

  Future<bool> isPermissionGranted() async {
    PermissionStatus permissionNotificationStatus;
    permissionNotificationStatus = await Permission.notification.status;

    if (permissionNotificationStatus == PermissionStatus.denied) {
      permissionNotificationStatus = await Permission.notification.request();
      if (permissionNotificationStatus != PermissionStatus.granted) {
        return false;
      }
    } else if (permissionNotificationStatus ==
        PermissionStatus.permanentlyDenied) {
      Get.to(hand.openAppSettings());
      isPermissionGranted();
      return false;
    }

    return permissionNotificationStatus == PermissionStatus.granted;
  }

  Future<void> subscribeToTopicNewProduct({
    required String subscribeToTopic,
  }) async {
    await FirebaseMessaging.instance.subscribeToTopic(subscribeToTopic);
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      (fcmToken);
      storage.setFcmToken(fcmToken);
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      MessageNewProduct.instance.showInApp(message: message);
    });
  }
}
