import 'package:dio/src/dio_exception.dart';
import 'package:flutter/foundation.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

class ApiResultInitial<T> extends ApiResult<T> {
  const ApiResultInitial();
}

class ApiResultLoading<T> extends ApiResult<T> {
  const ApiResultLoading();
}

class ApiResultSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiResultSuccess(this.data);
}

class ApiResultFailure<T> extends ApiResult<T> {
  final String? errorMessage;
  ApiResultFailure(this.errorMessage);
}

class ErrorHandler implements Exception {
  String _errorMessage = "";

  ErrorHandler(this._errorMessage);

  ErrorHandler.dioException({required DioException error}) {
    _handleDioException(error);
  }

  ErrorHandler.otherException({Exception? error}) {
    _handleOtherException(error);
  }

  get errorMessage {
    return _errorMessage;
  }

  // Untracked error
  _handleOtherException(Exception? error) {
    _errorMessage = error != null ? error.toString() : "Something went wrong";
    ErrorHandler serverError = ErrorHandler(_errorMessage);
    return serverError;
  }

  // Dio Exception - tracked error
  _handleDioException(DioException error) {
    ErrorHandler serverError;
    switch (error.type) {
      case DioExceptionType.cancel:
        _errorMessage = "Request Canceled";
        serverError = ErrorHandler(_errorMessage);
        break;
      case DioExceptionType.connectionTimeout:
        _errorMessage = "Connection time out";
        serverError = ErrorHandler(_errorMessage);
        break;
      case DioExceptionType.receiveTimeout:
        _errorMessage = "Received timeout";
        serverError = ErrorHandler(_errorMessage);
        break;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 503) {
          _errorMessage = "Something went wrong";
          serverError = ErrorHandler(_errorMessage);
        } else if (error.response?.statusCode != 401) {
          final errorRes = error.response?.data;
          if (errorRes is Map<String, dynamic>) {
            _errorMessage = handleBadRequest(errorRes);
          } else {
            _errorMessage = error.message ?? "Something went wrong";
          }
          serverError = ErrorHandler(_errorMessage);
        } else {
          _errorMessage = "UnAuthorized";
          serverError = ErrorHandler(_errorMessage);
        }
        break;
      case DioExceptionType.unknown:
        _errorMessage = "Something went wrong";
        serverError = ErrorHandler(_errorMessage);
        break;
      case DioExceptionType.sendTimeout:
        if (kReleaseMode) {
          _errorMessage = "Something went wrong";
        } else {
          _errorMessage = "Received timeout";
        }
        serverError = ErrorHandler(_errorMessage);
        break;
      case DioExceptionType.connectionError:
        _errorMessage = "No Internet connection";
        serverError = ErrorHandler(_errorMessage);
        break;
      default:
        _errorMessage = error.response?.statusMessage ?? "Something went wrong";
        serverError = ErrorHandler(_errorMessage);
        break;
    }
    return serverError;
  }

  // Extract the errorMessage from JSON res body received from BE
  String handleBadRequest(Map<String, dynamic>? errorJsonData) {
    if (errorJsonData?['errorMessage'] != null) {
      return errorJsonData?['errorMessage'];
    }
    return "Something went wrong, unknown error";
  }
}
