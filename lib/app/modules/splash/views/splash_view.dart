import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white54,
      body: SafeArea(
        child: Container(
          // margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}
