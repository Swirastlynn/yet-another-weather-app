import 'dart:async';

import 'package:dio/dio.dart';

import '../tools/logger.dart';
import 'dio_network_exceptions.dart';

const _defaultConnectTimeout = 5000;
const _defaultReceiveTimeout = 3000;

class DioApiManager {
  final Dio _dio = Dio(
    BaseOptions(
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      connectTimeout: const Duration(milliseconds: _defaultConnectTimeout),
      receiveTimeout: const Duration(milliseconds: _defaultReceiveTimeout),
    ),
  );

  // todo Either instead dynamic
  Future<dynamic> getAPICall(String url) async {
    logger.d("Calling API: $url");

    try {
      Response response = await _dio.get(url);
      return response.data;
    } on DioError catch (dioError) {
      var exception =
          NetworkExceptionsManager().transformToNetworkException(dioError);
      String errorMessage = exception.message;
      logger.e('Exception $errorMessage');
      // todo here should be non-fatal Crashlytics remote logging
      throw exception;
    }
  }
}
