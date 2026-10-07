import 'package:dio/dio.dart';
import 'package:tourist_app/core/error/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  const ServerException({required this.errModel});
}

Never handleDioExceptions(DioException e) {
  final responseData = e.response?.data;

  if (responseData is Map<String, dynamic>) {
    throw ServerException(errModel: ErrorModel.fromJson(responseData));
  }

  String message;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      message = 'Connection timeout. Please try again.';
      break;

    case DioExceptionType.sendTimeout:
      message = 'Request timeout. Please try again.';
      break;

    case DioExceptionType.receiveTimeout:
      message = 'Server took too long to respond.';
      break;

    case DioExceptionType.connectionError:
      message = 'No internet connection.';
      break;

    case DioExceptionType.badCertificate:
      message = 'Secure connection failed.';
      break;

    case DioExceptionType.cancel:
      message = 'Request was cancelled.';
      break;

    case DioExceptionType.badResponse:
      message = 'Server error. Please try again.';
      break;

    case DioExceptionType.unknown:
      message = 'Something went wrong. Please try again.';
      break;
    case DioExceptionType.transformTimeout:
      message = 'Request timeout. Please try again.';
      break;
  }

  throw ServerException(
    errModel: ErrorModel(
      status: e.response?.statusCode ?? 0,
      errorMessage: message,
    ),
  );
}
