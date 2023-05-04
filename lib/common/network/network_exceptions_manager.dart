import 'dart:io';

import 'package:dio/dio.dart';

class NetworkExceptionsManager {
  NetworkExceptionsManager._internal();

  factory NetworkExceptionsManager() => NetworkExceptionsManager._internal();

  NetworkException transformToNetworkException(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return const NetworkException.connectionTimeout();
      case DioErrorType.sendTimeout:
        return const NetworkException.sendTimeout();
      case DioErrorType.receiveTimeout:
        return const NetworkException.receiveTimeout();
      case DioErrorType.badCertificate:
        return const NetworkException.badCertificate();
      case DioErrorType.badResponse:
        Response? errorResponse = dioError.response;
        return _handleBadResponseError(
            dioError.response?.statusCode ?? -1,
            (errorResponse != null)
                ? "${errorResponse.data}\n${errorResponse.headers}\n${errorResponse.requestOptions}"
                : "${dioError.requestOptions}\n${dioError.message}");
      case DioErrorType.cancel:
        return const NetworkException.cancelRequest();
      case DioErrorType.connectionError:
        return const NetworkException.connectionError();
      case DioErrorType.unknown:
        if (dioError.error is SocketException) {
          return const NetworkException.socketException();
        } else if (dioError.error is FormatException) {
          return const NetworkException.invalidFormatException();
        } else {
          return const NetworkException.otherNetworkIssue();
        }
    }
  }

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

  const NetworkException.connectionTimeout() : message = "Connection timeout";
  const NetworkException.sendTimeout() : message = "Send timeout";
  const NetworkException.receiveTimeout() : message = "Receive timeout";
  const NetworkException.badCertificate() : message = "Bad certificate";
  const NetworkException.cancelRequest() : message = "Cancel request";
  const NetworkException.connectionError() : message = "Connection error";
  const NetworkException.otherNetworkIssue() : message = "Other network issue";
  const NetworkException.socketException() : message = "Socket exception";
  const NetworkException.invalidFormatException()
      : message = "Invalid format exception";
  const NetworkException.invalidResponseType()
      : message = "Invalid response type";

  @override
  String toString() => message;
}

// A set of exceptions inferred from the status codes.
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
