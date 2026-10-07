import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/core/widgets/app_text_button.dart';
import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/features/login/view/widgets/dont_have_account_text.dart';
import 'package:tourist_app/features/login/view/widgets/email_and_password.dart';
import 'package:tourist_app/features/login/view_model/cubit/login_cubit.dart';
import 'package:tourist_app/features/login/view_model/cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            showToast('Login successful');
          } else if (state is LoginError) {
            showToast(state.message);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(16),
                    Text(
                      'Sign in to continue your journey',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    verticalSpace(80),
                    const EmailAndPassword(),
                    verticalSpace(60),
                    state is LoginLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : AppTextButton(
                            buttonText: "Login",
                            onPressed: () {
                              validateThenDoLogin(context);
                            },
                          ),
                    verticalSpace(40),
                    const DontHaveAccountText(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().signInFormKey.currentState!.validate()) {
      context.read<LoginCubit>().signIn();
    }
  }
}
