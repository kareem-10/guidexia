import 'package:tourist_app/core/api/end_ponits.dart';

class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      status: _parseStatus(json[ApiKey.status] ?? json['status']),
      errorMessage: _extractMessage(json),
    );
  }

  static int _parseStatus(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static String _extractMessage(Map<String, dynamic> json) {
    final candidates = [
      json[ApiKey.errorMessage],
      json[ApiKey.message],
      json['detail'],
      json['title'],
    ];

    for (final value in candidates) {
      if (value is String && value.trim().isNotEmpty) {
        return value;
      }
    }

    final errors = json['errors'];

    if (errors is Map) {
      final messages = <String>[];

      for (final value in errors.values) {
        if (value is List) {
          messages.addAll(value.whereType<String>().where((e) => e.isNotEmpty));
        } else if (value is String && value.isNotEmpty) {
          messages.add(value);
        }
      }

      if (messages.isNotEmpty) {
        return messages.join('\n');
      }
    }

    return 'Something went wrong. Please try again.';
  }
}
