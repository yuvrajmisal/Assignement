import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingHelper {
  static easyLoading({String? message = ''}) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..indicatorColor = Colors.white
      ..backgroundColor = Colors.grey
      // ..backgroundColor = Colors.omantelBlue
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..dismissOnTap = false
      ..userInteractions = false
      ..maskColor = Colors.transparent;
    EasyLoading.show(status: message, maskType: EasyLoadingMaskType.custom);
  }

  static Future<void> showProcessing(
      {required bool show,
      required bool hide,
      int? seconds = 1,
      String? message = 'Loading...',
      Function? onCompleteProcessing}) async {
    if (show) _showLoader(message);
    await Future.delayed(
        Duration(seconds: seconds!), () => onCompleteProcessing);
    // Logger.print('JSONHelper showProcessing:');
  }

  static _showLoader(String? message) async {
    if (EasyLoading.isShow != null && EasyLoading.isShow) {
      return;
    }
    easyLoading(message: message);
  }

  static showLoader({String? message = 'Loading'}) async {
    if (EasyLoading.isShow != null && EasyLoading.isShow) {
      return;
    }
    easyLoading(message: message);
  }

  static hideLoader() async {
    if (EasyLoading.isShow != null && !EasyLoading.isShow) {
      return;
    }
    await EasyLoading.dismiss(animation: true);
  }
}
