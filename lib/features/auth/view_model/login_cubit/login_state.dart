import 'package:tourist_app/features/auth/data/models/auth_model.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final AuthModel user;

  LoginSuccess({required this.user});
}

final class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}
