import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:repo_finder/data/network/api_failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}

class ApiException implements Exception {
  late ApiFailure failure;

  ApiException.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its error from response of the API
      String message = error.response?.data?['message'] ?? '';
      failure = _handleError(error, message);
    } else {
      // default error
      log("Json data not found");
      failure = DataSource.defaultError.getFailure(error);
    }
  }

  ApiFailure _handleError(DioException error, String apiError) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure(apiError);
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure(apiError);
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure(apiError);
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure(apiError);
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure(apiError);
          case ResponseCode.unauthorised:
            return DataSource.unauthorised.getFailure(apiError);
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure(apiError);
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure(apiError);
          default:
            return _getResponseError(error);
        }
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure(apiError);
      default:
        return DataSource.defaultError.getFailure(apiError);
    }
  }

  ApiFailure _getResponseError(DioException error) {
    late String message;
    try {
      int code = error.response?.statusCode ?? 0;
      message = error.response?.data?['message'] ?? '';
      // Map errorMessage = error.response?.data ?? {};
      return ApiFailure(code);
    } on Exception {
      return DataSource.defaultError.getFailure(message);
    }
  }
}

extension DataSourceExtension on DataSource {
  ApiFailure getFailure(String apiError) {
    switch (this) {
      case DataSource.badRequest:
        return ApiFailure(ResponseCode.badRequest);

      default:
        return ApiFailure(ResponseCode.defaultError);
    }
  }
}

class ResponseMessage {
  static const String noContent = 'success with no content';
  static const String badRequest = 'failure, api rejected our request';
}
