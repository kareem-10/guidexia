import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/login/data/models/sign_in_model.dart';
import 'package:tourist_app/features/login/data/repos/login_repo.dart';
import 'package:tourist_app/features/login/view_model/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  final LoginRepo loginRepo;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();

  SignInModel? user;

  Future<void> signIn() async {
    emit(LoginLoading());
    final response = await loginRepo.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );
    response.fold(
      (errMessage) => emit(LoginError(message: errMessage)),
      (signInModel) => emit(LoginSuccess()),
    );
  }
}
