import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/auth/data/models/auth_model.dart';
import 'package:tourist_app/features/auth/data/repos/signup_repo.dart';
import 'package:tourist_app/features/auth/view_model/signup_cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo signupRepo;

  SignupCubit(this.signupRepo) : super(SignupInitial());

  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController signUpEmail = TextEditingController();
  final TextEditingController signUpPassword = TextEditingController();
  final TextEditingController signUpConfirmPassword = TextEditingController();

  String selectedRole = 'Tourist';

  AuthModel? user;

  void selectRole(String role) {
    selectedRole = role;
    emit(SignupRoleChanged(role: role));
  }

  Future<void> signUp() async {
    emit(SignupLoading());

    final response = await signupRepo.signUp(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: signUpEmail.text.trim(),
      password: signUpPassword.text,
      role: selectedRole,
    );

    response.fold(
      (errorMessage) {
        emit(SignupError(message: errorMessage));
      },
      (authModel) {
        user = authModel;
        emit(SignupSuccess(user: authModel));
      },
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    signUpEmail.dispose();
    signUpPassword.dispose();
    signUpConfirmPassword.dispose();

    return super.close();
  }
}
