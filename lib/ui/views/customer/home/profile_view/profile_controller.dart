import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';
import 'package:simple_e_commerce/core/enums/request_status.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';

class ProfileController extends BaseController {
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  Rx<RequestStatus> requestStatus = RequestStatus.DEFUALT.obs;

  // لتتبع اللغة الحالية
  RxString currentLangCode =
      Get.locale?.languageCode.obs ?? 'en'.obs; // 'en' كافتراضي

  // SharedPreferenceRepository storageService = Get.find(); // إذا كنت تسجله
  final List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'ar', 'name': 'العربية'},
    // أضف لغات أخرى هنا
  ];

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
    // تحديث currentLangCode بناءً على لغة GetX الحالية
    currentLangCode.value = Get.locale?.languageCode ?? 'en';
  }

  Future<void> loadUserProfile() async {
    requestStatus.value = RequestStatus.LOADING;
    try {
      // --- بيانات وهمية ---
      await Future.delayed(const Duration(milliseconds: 500));
      // UserModel? storedUser = storageService.getUserInfo();
      // if (storedUser != null) {
      //   currentUser.value = storedUser;
      // } else {
      //   // بيانات افتراضية إذا لم يكن المستخدم مسجلاً أو لا توجد بيانات
      //    currentUser.value = UserModel(
      //     id: "0",
      //     firstName: "Guest",
      //     lastName: "User",
      //     email: "guest@example.com",
      //     role: "Guest",
      //     avatar: "https://via.placeholder.com/150/CCCCCC/FFFFFF?Text=User",
      //   );
      // }
      currentUser.value = UserModel(
        userName: "Ahmad",
        email: "ahmad.naser@example.com",
        role: "Customer",
        // avatar: "https://randomuser.me/api/portraits/men/75.jpg",
      );
      requestStatus.value = RequestStatus.SUCCESS;
    } catch (e) {
      print("Error loading user profile: $e");
      requestStatus.value = RequestStatus.ERROR;
      currentUser.value = UserModel(
        userName: "Error",
        email: "N/A",
        role: "N/A",
        // avatar: "https://via.placeholder.com/150/FF0000/FFFFFF?Text=Error",
      );
    }
  }

  void editProfile() {
    // Get.toNamed('/edit-profile', arguments: currentUser.value); // تمرير بيانات المستخدم الحالي
    Get.snackbar("Navigation", "Navigate to Edit Profile Screen");
  }

  void changePassword() {
    // Get.toNamed('/change-password');
    Get.snackbar("Navigation", "Navigate to Change Password Screen");
  }

  void changeLanguage(String langCode) {
    Locale newLocale = Locale(langCode);
    // storageService.setAppLanguage(langCode); // حفظ اللغة المختارة
    Get.updateLocale(newLocale); // تحديث لغة التطبيق عبر GetX
    currentLangCode.value = langCode; // تحديث المتغير المحلي
    update(); // لإعادة بناء أي GetBuilders إذا كنت تستخدمها
  }

  void contactUs() {
    // يمكنك فتح رابط، عرض dialog بمعلومات الاتصال، أو الانتقال لصفحة مخصصة
    Get.defaultDialog(
      title: "Contact Us",
      middleText:
          "For support, please contact us at:\nEmail: @email\nPhone: @phone"
              .trParams({
                'email': "laithalskaf@gmail.com",
                'phone': "+963982055788",
              }),
      textConfirm: "tr_ok".tr,
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  void aboutApp() {
    Get.defaultDialog(
      title: "About App",
      middleText: "App Name: Ecommerce\nVersion: @version\n© 2023 Laith"
          .trParams({'appName': "My E-Commerce App", 'version': "1.0.0"}),
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }
}
