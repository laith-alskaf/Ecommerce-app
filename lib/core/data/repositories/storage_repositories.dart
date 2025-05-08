import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_e_commerce/core/data/models/api/cart_model.dart';
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';

class SharedPreferenceRepositories {
  static SharedPreferences globalSharedPreferences = Get.find();

  //!----Keys----
  String tokenKey = 'token';
  String languageKey = 'language';
  String roleKey = 'role';
  String userInfoKey = 'user-info';
  String PREF_CART_LIST = 'cart_list';

  void setToken(String token) {
    setPreference(
      dataType: DataType.STRING,
      key: tokenKey,
      value: token,
    );
  }

  String getToken() {
    if (globalSharedPreferences.containsKey(tokenKey)) {
      return getPreference(key: tokenKey);
    } else {
      return '';
    }
  }

  void setAppLanguage(String language) {
    setPreference(
      dataType: DataType.STRING,
      key: languageKey,
      value: language,
    );
  }

  String getAppLanguage() {
    if (globalSharedPreferences.containsKey(languageKey)) {
      return getPreference(key: languageKey);
    } else {
      return '';
    }
  }

  void setRole(String role) {
    setPreference(
      dataType: DataType.STRING,
      key: roleKey,
      value: role,
    );
  }

  String getRole() {
    if (globalSharedPreferences.containsKey(roleKey)) {
      return getPreference(key: roleKey);
    } else {
      return '';
    }
  }

  void setUserinfo(UserModel user) {
    String userJson = jsonEncode(user.toJson());
    setPreference(
      dataType: DataType.STRING,
      key: userInfoKey,
      value: userJson,
    );
  }
  UserModel? getUserinfo() {
    if (globalSharedPreferences.containsKey(userInfoKey)) {
      String? userJson = getPreference(key: userInfoKey) as String?;
      if(userJson != null){
        return UserModel.fromJson(jsonDecode(userJson));
      }
      else{
        return null;
      }

    } else {
      return null;
    }
  }
  void setCartList(List<CartModel> list) {
    setPreference(
      dataType: DataType.STRING,
      key: PREF_CART_LIST,
      value: CartModel.encode(list),
    );
  }
  List<CartModel> getCartList() {
    if (globalSharedPreferences.containsKey(PREF_CART_LIST)) {
      return CartModel.decode(getPreference(key: PREF_CART_LIST));
    } else {
      return [];
    }
  }


  setPreference(
      {required DataType dataType,
      required String key,
      required dynamic value}) async {
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
  }
}

enum DataType { INT, DOUBLE, STRING, BOOL, LISTSTRING }
