import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:robofriends/app/helper/snackbar_helper.dart';

import 'connectivity_helper.dart';
import 'easy_loading_helper.dart';
import 'logger.dart';

class NetworkHelper {
  static String get URL => "";
  // https://jsonplaceholder.typicode.com/users
  // https://robohash.org/1?200x200
  // https://robohash.org/{id}?200x200
  static NetworkHelper _networkHelper = NetworkHelper();

  static NetworkHelper networkHelper() {
    return _networkHelper;
  }

  Future<dynamic> get({
    required String url,
    required dynamic headers,
    dynamic body,
    required bool loading,
    required bool alert,
    required bool success,
    int? timeout = 60,
    required Function onTryAgain,
  }) async {
    var responseJson;
    bool isOnline = await ConnectivityHelper.isConnected();
    if (!isOnline) {
      if (alert == true) {
        return SnackbarHelper.showError(
            "No Internet",
            "Please check your Internet Connection and try again.",
            "Close",
            true,
            () {});
      }
      return;
    }
    try {
      if (Get.isDialogOpen != null && Get.isDialogOpen!) {
        Get.back(closeOverlays: false);
      }
      if (loading) {
        EasyLoadingHelper.easyLoading();
      }
      Logger.print('before ');

      var uri = Uri.parse(url);
      Uri? uri1;
      if (body != null)
        uri1 = uri.replace(queryParameters: body);
      else
        uri1 = uri;

      final http.Response response =
          await http.get(uri1).timeout(Duration(seconds: timeout!));

      Logger.print('GET url == ${url} ');
      Logger.print('GET response.statusCode == ${response.statusCode} ');
      Logger.print("GET Response : \n" + utf8.decode(response.bodyBytes));

      responseJson = response;
    } on SocketException catch (e, s) {
      SnackbarHelper.showError(
          "No Internet",
          "Please check your Internet Connection and try again.",
          "Close",
          true,
          () {});
      Logger.print(' SocketException Exception info: ${e}');
      Logger.print(' SocketException Stack Trace: ${s}');
    } on TimeoutException catch (_) {
      if (loading) EasyLoadingHelper.hideLoader();
    } on Exception catch (e, s) {
      Logger.print('Exception Exception info: ${e}');
      Logger.print('Exception Stack Trace: ${s}');
    } finally {
      if (loading) EasyLoadingHelper.hideLoader();
    }
    return responseJson;
  }

  Future<dynamic> post({
    required dynamic body,
    required String url,
    dynamic headers,
    required bool loading,
    required bool alert,
    required bool success,
    Function? onTryAgain,
    int? timeout = 60,
  }) async {
    var responseJson;
    bool isOnline = await ConnectivityHelper.isConnected();
    if (!isOnline) {
      if (alert == true) {
        return SnackbarHelper.showError(
            "No Internet",
            "Please check your Internet Connection and try again.",
            "Close",
            true,
                () {});
      }
      return;
    }
    try {
      if (Get.isDialogOpen != null && Get.isDialogOpen!) {
        Get.back(closeOverlays: false);
      }
      if (loading) {
        EasyLoadingHelper.easyLoading();
      }
      Logger.print('before ');

      final http.Response response = await http
          .post(
        Uri.parse(url),
        body: json.encode(body), // body,
      )
          .timeout(Duration(seconds: timeout!));

      Logger.print('post url == ${url} ');
      Logger.print('post response.statusCode == ${response.statusCode} ');
      Logger.print("post Response : \n" + utf8.decode(response.bodyBytes));

      responseJson = response;
    } on SocketException catch (e, s) {
      SnackbarHelper.showError(
          "No Internet",
          "Please check your Internet Connection and try again.",
          "Close",
          true,
              () {});
      Logger.print(' SocketException Exception info: ${e}');
      Logger.print(' SocketException Stack Trace: ${s}');
    } on TimeoutException catch (_) {
      if (loading) EasyLoadingHelper.hideLoader();
    } on Exception catch (e, s) {
      Logger.print('Exception Exception info: ${e}');
      Logger.print('Exception Stack Trace: ${s}');
    } finally {
      if (loading) EasyLoadingHelper.hideLoader();
    }
    return responseJson;
  }

}
