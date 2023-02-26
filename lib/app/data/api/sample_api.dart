import 'package:http/http.dart' as http;

import '../../helper/logger.dart';
import '../../helper/network_helper.dart';
import '../../helper/response_helper.dart';

class SampleApi {
  static String URL = NetworkHelper.URL;
  static NetworkHelper _laNetworkHelper = NetworkHelper.networkHelper();

  static Future<ResponseData> getUsers({
    bool alert: true,
    bool showLoading: true,
    required Function onTry,
  }) async {
    http.Response? response;
    Exception? exception;
    try {
      var url = "https://jsonplaceholder.typicode.com/users";
      Logger.print('getUsers URL - $url');

      response = await _laNetworkHelper.get(
        url: url,
        // body: data,
        alert: alert,
        loading: showLoading,
        onTryAgain: onTry,
        headers: null,
        success: false,
      );
    } on Exception catch (e) {
      Logger.print('getUsers response error : ' + e.toString());
      exception = e;
    }
    ResponseData responseData =
    ResponseHelper.handleResponse(response, exception);
    return responseData;
  }

  static Future<ResponseData> getPhotoById({
    String? id,
    bool alert: true,
    bool showLoading: true,
    required Function onTry,
  }) async {
    http.Response? response;
    Exception? exception;
    try {
      var url = "https://robohash.org/${id}?200x200";
      Logger.print('getPhotoById URL - $url');

      response = await _laNetworkHelper.get(
        url: url,
        // body: data,
        alert: alert,
        loading: showLoading,
        onTryAgain: onTry,
        headers: null,
        success: false,
      );
    } on Exception catch (e) {
      Logger.print('getPhotoById response error : ' + e.toString());
      exception = e;
    }
    ResponseData responseData =
    ResponseHelper.handleResponse(response, exception);
    return responseData;
  }
}
