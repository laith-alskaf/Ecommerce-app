import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/core/data/repositories/storage_repositories.dart';
import 'package:simple_e_commerce/core/enums/connectivity_status.dart';
import 'package:simple_e_commerce/core/services/notification_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_e_commerce/core/services/connectivity_service.dart';
import 'package:simple_e_commerce/app/my_app_controller.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/ui/shared/utils.dart';

// SharedPreferenceRepositories get storage =>
//     Get.find<SharedPreferenceRepositories>();

SharedPreferenceRepositories get storage => sl<SharedPreferenceRepositories>();

ConnectivityService get connectivityService => Get.find<ConnectivityService>();

MyAppController get myAppController => Get.find<MyAppController>();

NotificationService get notificationService => Get.find<NotificationService>();

// CartServices get cartServices => Get.find<CartServices>();
// LocationService get locationService => Get.find<LocationService>();

double get sizeTextTitle => 30.sp; //30

double get sizeTextSupHeader => 27.sp; //25

double get sizeTextBodyBig => 22.sp; //20

double get sizeTextBody => 20.sp; //18

double get defaultSizeSmall => 18.sp; //16

double get defaultPadding => 35.w; //16

bool get isOnline =>
    Get.find<MyAppController>().connectivityStatus == ConnectivityStatus.ONLINE;

bool get isOffline =>
    myAppController.connectivityStatus == ConnectivityStatus.OFFLINE;

void checkConnection(Function function) {
  if (isOnline) {
    function();
  } else {
    showNoConnectionMessage();
  }
}

double get taxAmount => 0.18;

double get deliveryAmount => 0.1;
// socket_io.Socket socket = socket = socket_io.io(
//   'http://192.168.137.1:5000/',
//   <String, dynamic>{
//     'transports': ['websocket'],
//     'autoConnect': false,
//   },
// );
