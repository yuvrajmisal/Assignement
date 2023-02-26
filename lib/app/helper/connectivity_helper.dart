import 'package:connectivity_wrapper/connectivity_wrapper.dart';

class ConnectivityHelper {
  static Future<bool> isConnected() async {
    return await ConnectivityWrapper.instance.isConnected;
  }
}