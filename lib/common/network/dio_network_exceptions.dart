import 'dart:io';

import 'package:dio/dio.dart';

/// Network exception For DIO package

class NetworkExceptionsManager {
  NetworkExceptionsManager._internal();

  factory NetworkExceptionsManager() => NetworkExceptionsManager._internal();

  NetworkException transformToNetworkException(DioError dioError) {
    NetworkException networkException;
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        networkException = ConnectionTimeoutException();
        break;
      case DioErrorType.sendTimeout:
        networkException = SendTimeoutException();
        break;
      case DioErrorType.receiveTimeout:
        networkException = ReceiveTimeoutException();
        break;
      case DioErrorType.badCertificate:
        networkException = BadCertificateException();
        break;
      case DioErrorType.badResponse:
        Response? errorResponse = dioError.response;
        networkException = _handleError(
            dioError.response?.statusCode ?? -1,
            (errorResponse != null)
                ? "${errorResponse.data}\n${errorResponse.headers}\n${errorResponse.requestOptions}"
                : "${dioError.requestOptions}\n${dioError.message}");
        break;
      case DioErrorType.cancel:
        networkException = CancelRequestException();
        break;
      case DioErrorType.connectionError:
        networkException = ConnectionErrorException();
        break;
      case DioErrorType.unknown:
        if (dioError.error is SocketException) {
          networkException = const NoInternetConnectionException();
        } else if (dioError.error is FormatException) {
          networkException = const InvalidFormatException();
        } else {
          networkException = OtherNetworkException();
        }
        break;
    }
    return networkException;
  }

  // you can add specific cases if this is required
  NetworkException _handleError(int statusCode, String errorMessage) {
    if (statusCode >= 400 && statusCode < 500) {
      return ApiException(statusCode);
    } else if (statusCode >= 500) {
      return ServerException(statusCode);
    } else {
      return NotAppSupportedStatusCodeException(statusCode);
    }
  }
}

abstract class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => message;
}

class ConnectionTimeoutException implements NetworkException {
  ConnectionTimeoutException._internal();

  factory ConnectionTimeoutException() =>
      ConnectionTimeoutException._internal();

  @override
  String get message => "Connection timeout";
}

class SendTimeoutException implements NetworkException {
  SendTimeoutException._internal();

  factory SendTimeoutException() => SendTimeoutException._internal();

  @override
  String get message => "Send timeout";
}

class ReceiveTimeoutException implements NetworkException {
  ReceiveTimeoutException._internal();

  factory ReceiveTimeoutException() => ReceiveTimeoutException._internal();

  @override
  String get message => "Receive timeout";
}

class BadCertificateException implements NetworkException {
  BadCertificateException._internal();

  factory BadCertificateException() => BadCertificateException._internal();

  @override
  String get message => "Bad certificate";
}

class CancelRequestException implements NetworkException {
  CancelRequestException._internal();

  factory CancelRequestException() => CancelRequestException._internal();

  @override
  String get message => "Cancel request";
}

class ConnectionErrorException implements NetworkException {
  ConnectionErrorException._internal();

  factory ConnectionErrorException() => ConnectionErrorException._internal();

  @override
  String get message => "Connection Error";
}

class OtherNetworkException implements NetworkException {
  OtherNetworkException._internal();

  factory OtherNetworkException() => OtherNetworkException._internal();

  @override
  String get message => "Other network issue";
}

// inferred from status code exceptions START
class ApiException implements NetworkException {
  final int statusCode;

  const ApiException(this.statusCode);

  @override
  String get message =>
      'Error occured while Communication from the App with StatusCode: $statusCode';
}

class ServerException implements NetworkException {
  final int statusCode;

  const ServerException(this.statusCode);

  @override
  String get message =>
      'Error occured while Communication with Server with StatusCode: $statusCode';
}

class NotAppSupportedStatusCodeException implements NetworkException {
  final int statusCode;

  const NotAppSupportedStatusCodeException(this.statusCode);

  @override
  String get message => 'Not supported status code $statusCode';
}
// inferred from status code exceptions END

class NoInternetConnectionException implements NetworkException {
  const NoInternetConnectionException();

  @override
  String get message => 'No Internet Connection';
}

class InvalidFormatException implements NetworkException {
  const InvalidFormatException();

  @override
  String get message => 'Invalid format';
  // todo All the above methods are the same except message.
  // todo How about creating an object with messages and taking properly depending on the exception type?
}
