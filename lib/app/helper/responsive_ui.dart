import 'package:get/get.dart';

class ResponsiveUI {
  // BUTTON
  static const double buttonHeight = 50;
  static const double buttonRadius = 25;

  ResponsiveUI._internal();
  static final ResponsiveUI _singleton = ResponsiveUI._internal();
  factory ResponsiveUI() => _singleton;

  bool get isPhone => Get.context!.isPhone;
  bool get isSmallTablet => Get.context!.isSmallTablet;
  bool get isLargeTablet => Get.context!.isLargeTablet;

  double _screenHeight = Get.height;
  double _screenWidth = Get.width;

  double _smallTabMultiplier = 0.8; //0.13;
  double _largeTabMultiplier = 1.5; //0.17;
  double _smallTabMultiplierFont = 0.3; //0.13;
  double _largeTabMultiplierFont = 0.35; //0.17;

  double height(double i) {
    double value = 0;

    if (ResponsiveUI().isSmallTablet) {
      value = _screenHeight * (_smallTabMultiplier + i) / 100;
      // Logger.print('small tab $value');
    } else if (ResponsiveUI().isLargeTablet) {
      value = _screenHeight * (_largeTabMultiplier + i) / 100;
      // Logger.print('Large Tablet $value');
    } else
      value = _screenHeight * i / 100;
    return value;
  }

  double width(double i) {
    double value = 0;

    if (ResponsiveUI().isSmallTablet)
      value = _screenWidth * (_smallTabMultiplier * i) / 100;
    else if (ResponsiveUI().isLargeTablet)
      value = _screenWidth * (_largeTabMultiplier * i) / 100;
    else
      value = _screenWidth * i / 100;
    return value;
  }

  double fontSize(double i) {
    double value = 0;

    if (ResponsiveUI().isSmallTablet)
      value = _screenHeight / 100 * ((_smallTabMultiplierFont + i) / 3);
    else if (ResponsiveUI().isLargeTablet)
      value = _screenHeight / 100 * ((_largeTabMultiplierFont + i) / 3);
    else
      value = _screenHeight / 100 * (i / 3);
    return value;
  }
}
