import 'dart:convert';

class AuthModel {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final String token;
  final DateTime expiresAt;

  AuthModel({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.token,
    required this.expiresAt,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String? ?? '',
      token: json['token'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }

  String get fullName =>
      [firstName, lastName].where((name) => name.trim().isNotEmpty).join(' ');

  String? get role {
    try {
      final parts = token.split('.');

      if (parts.length != 3) return null;

      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );

      final claims = jsonDecode(payload) as Map<String, dynamic>;

      return claims['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']
          ?.toString();
    } catch (_) {
      return null;
    }
  }
}
