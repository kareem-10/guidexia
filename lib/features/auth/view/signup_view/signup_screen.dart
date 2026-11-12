import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/functions/auth_navigation.dart';
import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/routing/routes.dart';
import 'package:tourist_app/core/widgets/app_text_button.dart';
import 'package:tourist_app/features/auth/view/signup_view/widgets/signup_form.dart';
import 'package:tourist_app/features/auth/view_model/signup_cubit/signup_cubit.dart';
import 'package:tourist_app/features/auth/view_model/signup_cubit/signup_state.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          showToast('Account created successfully');

          AuthNavigation.navigateByRole(context, state.user);
        } else if (state is SignupError) {
          showToast(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is SignupLoading;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 64.w,
                      width: 64.w,
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.travel_explore_rounded,
                        size: 34,
                        color: scheme.primary,
                      ),
                    ),
                  ),

                  verticalSpace(24),

                  Text(
                    'Create account',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  verticalSpace(8),

                  Text(
                    'Join us and start exploring amazing destinations.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),

                  verticalSpace(32),

                  const SignupForm(),

                  verticalSpace(28),

                  AppTextButton(
                    buttonText: 'Create Account',
                    onPressed: isLoading
                        ? null
                        : () => validateThenDoSignup(context),
                  ),

                  if (isLoading) ...[
                    verticalSpace(12),
                    Center(
                      child: Text(
                        'Creating your account...',
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],

                  verticalSpace(24),

                  Center(
                    child: TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.loginScreen,
                              );
                            },
                      child: const Text('Already have an account? Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void validateThenDoSignup(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    if (cubit.signupFormKey.currentState?.validate() ?? false) {
      cubit.signUp();
    }
  }
}
