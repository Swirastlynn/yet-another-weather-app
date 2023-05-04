import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'network_exceptions_manager.dart';

typedef Json = Map<String, dynamic>;

class DioApiManager {
  final NetworkExceptionsManager networkExceptionsManager;
  final Dio dio;
  final Logger logger;

  DioApiManager(this.networkExceptionsManager, this.dio, this.logger);

  Future<Json> getJsonAPICall(String url) async {
    logger.d("Calling url: $url");

    try {
      Response response = await dio.get(url);
      if (response.requestOptions.responseType == ResponseType.json) {
        return response.data;
      } else {
        throw const NetworkException.invalidResponseType();
      }
    } on DioError catch (dioError) {
      NetworkException exception =
          networkExceptionsManager.transformToNetworkException(dioError);
      String errorMessage = exception.message;
      logger.e('Exception $errorMessage'); // todo leave?
      // todo here should be non-fatal Crashlytics remote logging
      throw exception;
    }
  }
}
