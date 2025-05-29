import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/ui/views/splash_screen_view/splash_screen_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(540, 960),
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: false,
      child: GetMaterialApp(
        defaultTransition:
            GetPlatform.isAndroid
                ? Transition.leftToRight
                : Transition.cupertino,
        transitionDuration: const Duration(microseconds: 300),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SplashScreenView(),
      ),
    );
  }
}