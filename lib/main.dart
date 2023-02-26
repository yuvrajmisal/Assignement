import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/helper/easy_loading_helper.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(
        () async {
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);
      runApp(RoboMaterialApp());
    },
        (Object error, StackTrace stacktrace) async {
      EasyLoadingHelper.hideLoader();
      ///handle global error
    },
  );
}

class RoboMaterialApp extends GetView {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      title: "RoboFriends",
      defaultTransition: Transition.rightToLeft,
      // transitionDuration: Duration(milliseconds: 800),
      transitionDuration: Duration(milliseconds: 300),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
