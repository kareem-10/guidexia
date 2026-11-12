import 'package:tourist_app/features/auth/data/models/auth_model.dart';

abstract class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final AuthModel user;

  SignupSuccess({required this.user});
}

final class SignupError extends SignupState {
  final String message;

  SignupError({required this.message});
}

final class SignupRoleChanged extends SignupState {
  final String role;

  SignupRoleChanged({required this.role});
}
