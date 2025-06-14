import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_e_commerce/core/data/models/api/cart_model.dart';
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';

class SharedPreferenceRepositories {
  final SharedPreferences globalSharedPreferences;
  SharedPreferenceRepositories({required this.globalSharedPreferences});

  //!----Keys----
  String tokenKey = 'token';
  String languageKey = 'language';
  String roleKey = 'role';
  String userInfoKey = 'user-info';
  String carListKey = 'cart_list';
  String fcmToken = 'fcm_token';

  void setToken(String token) {
    setPreference(dataType: DataType.STRING, key: tokenKey, value: token);
  }

  void setFcmToken(String token) {
    setPreference(dataType: DataType.STRING, key: fcmToken, value: token);
  }

  String getFcmToken() {
    if (globalSharedPreferences.containsKey(fcmToken)) {
      return getPreference(key: fcmToken);
    } else {
      return '';
    }
  }

  String getToken() {
    if (globalSharedPreferences.containsKey(tokenKey)) {
      return getPreference(key: tokenKey);
    } else {
      return '';
    }
  }

  void setAppLanguage(String language) {
    setPreference(dataType: DataType.STRING, key: languageKey, value: language);
  }

  String getAppLanguage() {
    if (globalSharedPreferences.containsKey(languageKey)) {
      return getPreference(key: languageKey);
    } else {
      return '';
    }
  }

  void setRole(String role) {
    setPreference(dataType: DataType.STRING, key: roleKey, value: role);
  }

  String getRole() {
    if (globalSharedPreferences.containsKey(roleKey)) {
      return getPreference(key: roleKey);
    } else {
      return '';
    }
  }

  void setUserinfo(Map<String, dynamic> user) {
    String userJson = jsonEncode(user);
    setPreference(dataType: DataType.STRING, key: userInfoKey, value: userJson);
  }

  UserModel getUserinfo() {
    if (globalSharedPreferences.containsKey(userInfoKey)) {
      final decodedData = jsonDecode(getPreference(key: userInfoKey));
      UserModel userModel = UserModel.fromJson(decodedData);
      return userModel;
    } else {
      return UserModel();
    }
  }

  void setCartList(List<CartModel> list) {
    setPreference(
      dataType: DataType.STRING,
      key: carListKey,
      value: CartModel.encode(list),
    );
  }

  List<CartModel> getCartList() {
    if (globalSharedPreferences.containsKey(carListKey)) {
      return CartModel.decode(getPreference(key: carListKey));
    } else {
      return [];
    }
  }

  setPreference({
    required DataType dataType,
    required String key,
    required dynamic value,
  }) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedPreferences.setInt(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedPreferences.setDouble(key, value);
        break;
      case DataType.STRING:
        await globalSharedPreferences.setString(key, value);
        break;
      case DataType.BOOL:
        await globalSharedPreferences.setBool(key, value);
        break;

      case DataType.LISTSTRING:
        await globalSharedPreferences.setStringList(key, value);
        break;
    }
  }

  dynamic getPreference({required String key}) {
    return globalSharedPreferences.get(key);
  }

  clearPreference() {
    globalSharedPreferences.clear();
    log('=======> CLear clearPreference');
  }
}

enum DataType { INT, DOUBLE, STRING, BOOL, LISTSTRING }
