import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../common/network/network_exceptions_manager.dart';
import 'network/dio_api_manager.dart';

final baseUrlProvider =
    Provider<String>((ref) => "https://api.openweathermap.org/data/2.5");

final dioApiManagerProvider = Provider<DioApiManager>(
  (ref) => DioApiManager(
    ref.watch(networkExceptionsManagerProvider),
    ref.watch(dioProvider),
    ref.watch(loggerProvider),
  ),
);

final networkExceptionsManagerProvider =
    Provider<NetworkExceptionsManager>((ref) => NetworkExceptionsManager());

const _defaultConnectTimeout = 5000;
const _defaultReceiveTimeout = 3000;

final dioProvider = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      connectTimeout: const Duration(milliseconds: _defaultConnectTimeout),
      receiveTimeout: const Duration(milliseconds: _defaultReceiveTimeout),
    ),
  ),
);

final loggerProvider = Provider<Logger>(
  (ref) => Logger(
    printer: PrettyPrinter(),
  ),
);
