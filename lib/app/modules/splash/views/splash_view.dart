import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          // margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.black12,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12.withAlpha(40),
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
              ),
              BoxShadow(
                color: Colors.black12.withAlpha(40),
                spreadRadius: -4,
                blurRadius: 10,
              )
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black54,
                Colors.blueAccent,
                Colors.teal,
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
