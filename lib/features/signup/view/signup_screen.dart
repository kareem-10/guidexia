import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/theming/styles.dart';
import 'package:tourist_app/core/utils/app_colors.dart';
import 'package:tourist_app/core/widgets/app_text_button.dart';
import 'package:tourist_app/core/widgets/pick_image_widget.dart';
import 'package:tourist_app/features/signup/view/widgets/signup_form.dart';
import 'package:tourist_app/features/signup/view_model/cubit/signup_cubit.dart';
import 'package:tourist_app/features/signup/view_model/cubit/signup_state.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          showToast(state.message);
        } else if (state is SignupError) {
          showToast(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Create account',
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    verticalSpace(16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sign up to continue your journey',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    verticalSpace(32),
                    PickImageWidget(),
                    verticalSpace(16),
                    SignupForm(),
                    verticalSpace(40),
                    state is SignupLoading
                        ? CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : AppTextButton(
                            buttonText: "Create Account",
                            textStyle: TextStyles.font16WhiteSemiBold,
                            onPressed: () {
                              validateThenDoSignup(context);
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void validateThenDoSignup(BuildContext context) {
    if (context.read<SignupCubit>().signupFormKey.currentState!.validate()) {
      context.read<SignupCubit>().signUp();
    }
  }
}
