import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist_app/features/signup/data/repos/signup_repo.dart';
import 'package:tourist_app/features/signup/view_model/cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo signupRepo;

  SignupCubit(this.signupRepo) : super(SignupInitial());
  //Profile Pic
  XFile? profilePic;

  //Sign up form key
  GlobalKey<FormState> signupFormKey = GlobalKey();
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController signUpConfirmPassword = TextEditingController();

  void uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  Future<void> signUp() async {
    emit(SignupLoading());
    final response = await signupRepo.signUp(
      name: signUpName.text,
      phone: signUpPhoneNumber.text,
      email: signUpEmail.text,
      password: signUpPassword.text,
      confirmPassword: signUpConfirmPassword.text,
      profilePic: profilePic!,
    );
    response.fold(
      (errMessage) => emit(SignupError(message: errMessage)),
      (signUpModel) => emit(SignupSuccess(message: signUpModel.message)),
    );
  }
}
