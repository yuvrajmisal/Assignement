import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robofriends/app/helper/responsive_ui.dart';

class SnackbarHelper {
  static closeSnack() async {
    if (Get.isSnackbarOpen != null && Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }
  }

  static Future<void> showError(
    String title,
    String message,
    String buttonTitle,
    bool barrierDismissible,
    Function onAccepted,
  ) async {
    await closeSnack();
    Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: ResponsiveUI().fontSize(5),
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          overflow: TextOverflow.visible,
        ),
        maxLines: 3,
        softWrap: true,
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: ResponsiveUI().fontSize(4.2),
          fontWeight: FontWeight.w400,
          letterSpacing: 1.2,
          overflow: TextOverflow.visible,
        ),
        maxLines: 3,
        softWrap: true,
      ),
      isDismissible: barrierDismissible,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 10),
      backgroundColor: Colors.redAccent.withOpacity(0.5),
      colorText: Colors.white,
      borderColor: Colors.redAccent.withOpacity(0.8),
      borderRadius: ResponsiveUI().height(1),
      borderWidth: 1,
      barBlur: 5,
      padding: EdgeInsets.only(
        top: ResponsiveUI().height(2),
        bottom: ResponsiveUI().height(2),
        left: ResponsiveUI().height(2),
        right: ResponsiveUI().height(2),
      ),
      margin: EdgeInsets.only(
        top: ResponsiveUI().height(1),
        left: ResponsiveUI().height(1),
        right: ResponsiveUI().height(1),
      ),
      icon: Icon(
        Icons.error_rounded,
        color: Colors.white,
        size: ResponsiveUI().height(4), // 35
      ),
      snackbarStatus: (status) async {
        // handle snack bar status
        if (status == SnackbarStatus.CLOSED) {}
      },
    );
  }

  static void showInfo(
      String title,
      String message,
      String buttonTitle,
      bool barrierDismissible,
      Function onAccepted,
      ) async {
    await closeSnack();
    Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: ResponsiveUI().fontSize(5),
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          overflow: TextOverflow.visible,
        ),
        maxLines: 3,
        softWrap: true,
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: ResponsiveUI().fontSize(4.2),
          fontWeight: FontWeight.w400,
          letterSpacing: 1.2,
          overflow: TextOverflow.visible,
        ),
        maxLines: 3,
        softWrap: true,
      ),
      isDismissible: barrierDismissible,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 10),
      backgroundColor: Colors.blueAccent.withOpacity(0.8),
      colorText: Colors.white,
      borderColor: Colors.blue,
      borderRadius: ResponsiveUI().height(1),
      borderWidth: 1,
      barBlur: 5,
      padding: EdgeInsets.only(
        top: ResponsiveUI().height(2),
        bottom: ResponsiveUI().height(2),
        left: ResponsiveUI().height(2),
        right: ResponsiveUI().height(2),
      ),
      margin: EdgeInsets.only(
        top: ResponsiveUI().height(1),
        left: ResponsiveUI().height(1),
        right: ResponsiveUI().height(1),
      ),
      icon: Icon(
        Icons.info_rounded,
        color: Colors.white,
        size: ResponsiveUI().height(4), // 35
      ),
      snackbarStatus: (status) async {
        // handle snack bar status
        if (status == SnackbarStatus.CLOSED) {}
      },
    );
  }
}
