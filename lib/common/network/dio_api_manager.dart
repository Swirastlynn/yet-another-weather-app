import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:yet_another_weather_app/common/tools/logger.dart';

import 'network_exceptions_manager.dart';

typedef Json = Map<String, dynamic>;

const _defaultConnectTimeout = 5000;
const _defaultReceiveTimeout = 3000;

final dioApiManagerProvider = Provider<DioApiManager>(
  (ref) => DioApiManager(
    ref.read(networkExceptionsManagerProvider),
    ref.read(dioProvider),
    ref.read(loggerProvider),
  ),
);

final dioProvider = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      connectTimeout: const Duration(milliseconds: _defaultConnectTimeout),
      receiveTimeout: const Duration(milliseconds: _defaultReceiveTimeout),
    ),
  ),
);

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
        throw NetworkException.invalidResponseType();
      }
    } on DioError catch (dioError) {
      var exception =
          networkExceptionsManager.transformToNetworkException(dioError);
      String errorMessage = exception.message;
      logger.e('Exception $errorMessage'); // todo leave?
      // todo here should be non-fatal Crashlytics remote logging
      throw exception;
    }
  }
}
