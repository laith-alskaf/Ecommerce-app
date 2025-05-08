import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_e_commerce/app/my_app.dart';
import 'package:simple_e_commerce/core/data/repositories/storage_repositories.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/services/cart_servces/cart_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await Get.putAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });
  Get.put(SharedPreferenceRepositories());
  Get.put(CartServices());
  runApp(const MyApp());
}
