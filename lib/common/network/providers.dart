import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../tools/logger.dart';
import 'dio_api_manager.dart';
import 'network_exceptions_manager.dart';

part 'providers.g.dart';

const _defaultConnectTimeout = 5000;
const _defaultReceiveTimeout = 3000;

@riverpod
DioApiManager dioApiManager(DioApiManagerRef ref) {
  return DioApiManager(
    ref.watch(networkExceptionsManagerProvider),
    ref.watch(dioProvider),
    ref.watch(loggerProvider),
  );
}

@riverpod
Dio dio(DioRef ref) {
  return Dio(
    BaseOptions(
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      connectTimeout: const Duration(milliseconds: _defaultConnectTimeout),
      receiveTimeout: const Duration(milliseconds: _defaultReceiveTimeout),
    ),
  );
}

@riverpod
NetworkExceptionsManager networkExceptionsManager(
        NetworkExceptionsManagerRef ref) =>
    NetworkExceptionsManager();
