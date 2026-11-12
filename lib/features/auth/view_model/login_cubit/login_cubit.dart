import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/auth/data/models/auth_model.dart';
import 'package:tourist_app/features/auth/data/repos/login_repo.dart';
import 'package:tourist_app/features/auth/view_model/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  LoginCubit(this.loginRepo) : super(LoginInitial());

  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  final TextEditingController signInEmail = TextEditingController();
  final TextEditingController signInPassword = TextEditingController();

  AuthModel? user;

  Future<void> signIn() async {
    emit(LoginLoading());

    final response = await loginRepo.signIn(
      email: signInEmail.text.trim(),
      password: signInPassword.text,
    );

    response.fold(
      (errorMessage) {
        emit(LoginError(message: errorMessage));
      },
      (authModel) {
        user = authModel;
        emit(LoginSuccess(user: authModel));
      },
    );
  }

  @override
  Future<void> close() {
    signInEmail.dispose();
    signInPassword.dispose();
    return super.close();
  }
}
