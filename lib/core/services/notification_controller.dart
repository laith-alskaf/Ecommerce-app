import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as hand;
import 'package:simple_e_commerce/ui/shared/colors.dart';

class NotificationController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    initNotifications();
  }

  Future<void> initNotifications() async {
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/res_notification_icon',
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for payments',
          defaultColor: AppColors.mainColor,
          ledColor: AppColors.whiteColor,
          importance: NotificationImportance.Max,
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
        ),
      ],
      debug: true,
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        // await Permission.notification.request();
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
  ) async {}

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
}
