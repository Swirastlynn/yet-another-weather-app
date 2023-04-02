import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkExceptionsManagerProvider =
    Provider<NetworkExceptionsManager>((ref) => NetworkExceptionsManager());

class NetworkExceptionsManager {
  NetworkExceptionsManager._internal();

  factory NetworkExceptionsManager() => NetworkExceptionsManager._internal();

  NetworkException transformToNetworkException(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return NetworkException.connectionTimeout();
      case DioErrorType.sendTimeout:
        return NetworkException.sendTimeout();
      case DioErrorType.receiveTimeout:
        return NetworkException.receiveTimeout();
      case DioErrorType.badCertificate:
        return NetworkException.badCertificate();
      case DioErrorType.badResponse:
        Response? errorResponse = dioError.response;
        return _handleBadResponseError(
            dioError.response?.statusCode ?? -1,
            (errorResponse != null)
                ? "${errorResponse.data}\n${errorResponse.headers}\n${errorResponse.requestOptions}"
                : "${dioError.requestOptions}\n${dioError.message}");
      case DioErrorType.cancel:
        return NetworkException.cancelRequest();
      case DioErrorType.connectionError:
        return NetworkException.connectionError();
      case DioErrorType.unknown:
        if (dioError.error is SocketException) {
          return NetworkException.socketException();
        } else if (dioError.error is FormatException) {
          return NetworkException.invalidFormatException();
        } else {
          return NetworkException.otherNetworkIssue();
        }
    }
  }

  // You can add specific cases here
  NetworkException _handleBadResponseError(
      int statusCode, String errorMessage) {
    if (statusCode >= 400 && statusCode < 500) {
      return ClientException(statusCode);
    } else if (statusCode >= 500) {
      return ServerException(statusCode);
    } else {
      return NotAppSupportedStatusCodeException(statusCode);
    }
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException._internal(this.message);

  // todo localization without context
  factory NetworkException.connectionTimeout() {
    return NetworkException._internal("Connection timeout");
  }

  factory NetworkException.sendTimeout() {
    return NetworkException._internal("Send timeout");
  }

  factory NetworkException.receiveTimeout() {
    return NetworkException._internal("Receive timeout");
  }

  factory NetworkException.badCertificate() {
    return NetworkException._internal("Bad certificate");
  }

  factory NetworkException.cancelRequest() {
    return NetworkException._internal("Cancel request");
  }

  factory NetworkException.connectionError() {
    return NetworkException._internal("Connection error");
  }

  factory NetworkException.otherNetworkIssue() {
    return NetworkException._internal("Other network issue");
  }

  factory NetworkException.socketException() {
    return NetworkException._internal("Socket exception");
  }

  factory NetworkException.invalidFormatException() {
    return NetworkException._internal("Invalid format exception");
  }

  factory NetworkException.invalidResponseType() {
    return NetworkException._internal("Invalid response type");
  }

  @override
  String toString() => message;
}

// inferred from status code exceptions
class ClientException implements NetworkException {
  final int statusCode;

  const ClientException(this.statusCode);

  @override
  String get message =>
      'An error occured during communication with the app with status code = $statusCode';
}

class ServerException implements NetworkException {
  final int statusCode;

  const ServerException(this.statusCode);

  @override
  String get message =>
      'An error occured during communication with server with status code = $statusCode';
}

class NotAppSupportedStatusCodeException implements NetworkException {
  final int statusCode;

  const NotAppSupportedStatusCodeException(this.statusCode);

  @override
  String get message => 'Not supported status code $statusCode';
}
// inferred from status code exceptions END
