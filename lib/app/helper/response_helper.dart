import 'dart:convert';

import 'package:http/http.dart' as http;

import 'easy_loading_helper.dart';
import 'logger.dart';

class ResponseData {
  final String? response;
  final String? error;
  final int? statusCode;
  ResponseData({this.response, this.statusCode, this.error});
  @override
  String toString() {
    return "ResponseData {response: $response, statusCode: $statusCode, error: $error}";
  }
}

class ResponseHelper {
  static ResponseData handleResponse(
      http.Response? response, Exception? exception) {
    if (exception != null || response == null) {
      return ResponseData(
        error: 'Failed to process your request.',
        statusCode: 0,
        response: '',
      );
    }
    if (response != null) {
      int statusCode = 0;
      String responseBody = '';
      String errorstr = '';
      try {
        statusCode = response.statusCode;
        if (statusCode == 200) {
          // Logger.print('ResponseHelper success: ' + utf8.decode(response.bodyBytes));
          // Logger.print('ResponseHelper success: ' + response.body);
          responseBody = utf8.decode(response.bodyBytes);
        } else {
          Logger.print(
              'ResponseHelper failure: ' + utf8.decode(response.bodyBytes));
          errorstr = "Unknown error received";
        }
      } catch (e) {
        ///need to test by hiding loader
        EasyLoadingHelper.hideLoader();
        Logger.print(
          'handleResponse Error Parsing:' + e.toString(),
        );
        errorstr = '${e.toString()}';
      }
      return ResponseData(
        error: errorstr,
        statusCode: statusCode,
        response: responseBody,
      );
    } else {
      return ResponseData(
        error: 'Failed to process your request.',
        statusCode: 0,
        response: '',
      );
    }
  }

  static Future<ResponseData> handleStreamResponse(
      http.StreamedResponse? response, Exception? exception) async {
    if (exception != null || response == null) {
      return ResponseData(
        error: 'Failed to process your request.',
        statusCode: 0,
        response: '',
      );
    }
    if (response != null &&
        response.statusCode != null &&
        response.statusCode == 403) {
      return ResponseData(
        error:
            'Your session has expired. Please Log-in with username/password.',
        statusCode: response.statusCode,
        response: '',
      );
    }
    if (response != null) {
      int statusCode = 0;
      String responseBody = '';
      String errorstr = '';
      try {
        statusCode = response.statusCode;
        if (statusCode == 200) {
          // Logger.print('ResponseHelper success: ' + '${response.reasonPhrase}');
          final respStr = await response.stream.bytesToString();
          Logger.print('POST uploadFile response.stream == ${respStr} ');
          responseBody = respStr;
        } else {
          Logger.print('ResponseHelper failure: ' + '${response.reasonPhrase}');
          errorstr = "Unknown error received";
        }
      } catch (e) {
        ///need to test by hiding loader
        EasyLoadingHelper.hideLoader();
        Logger.print(
          'handleStreamResponse Error Parsing:' + e.toString(),
        );
        errorstr = '${e.toString()}';
      }
      return ResponseData(
        error: errorstr,
        statusCode: statusCode,
        response: responseBody,
      );
    } else {
      return ResponseData(
        error: 'Failed to upload documents.',
        statusCode: 0,
        response: '',
      );
    }
  }
}
