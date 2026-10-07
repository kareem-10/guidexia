import 'package:tourist_app/core/api/end_ponits.dart';

class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      status: json[ApiKey.status] is int ? json[ApiKey.status] : 0,
      errorMessage:
          json[ApiKey.errorMessage]?.toString() ??
          json[ApiKey.message]?.toString() ??
          'Something went wrong',
    );
  }
}
