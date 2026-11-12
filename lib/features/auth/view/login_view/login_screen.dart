import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/functions/auth_navigation.dart';
import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/routing/routes.dart';
import 'package:tourist_app/core/widgets/app_text_button.dart';
import 'package:tourist_app/features/auth/view/login_view/widgets/email_and_password.dart';
import 'package:tourist_app/features/auth/view_model/login_cubit/login_cubit.dart';
import 'package:tourist_app/features/auth/view_model/login_cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            showToast('Login successful');
            AuthNavigation.navigateByRole(context, state.user);
          } else if (state is LoginError) {
            showToast(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return SafeArea(
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

                  verticalSpace(32),

                  Text(
                    'Welcome back',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  verticalSpace(8),

                  Text(
                    'Sign in to continue your journey.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),

                  verticalSpace(48),

                  const EmailAndPassword(),

                  verticalSpace(32),

                  AppTextButton(
                    buttonText: 'Login',
                    onPressed: isLoading
                        ? null
                        : () => validateThenDoLogin(context),
                  ),

                  if (isLoading) ...[
                    verticalSpace(12),
                    Center(
                      child: Text(
                        'Signing in...',
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
                                Routes.signUpScreen,
                              );
                            },
                      child: const Text("Don't have an account? Sign up"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    if (cubit.signInFormKey.currentState?.validate() ?? false) {
      cubit.signIn();
    }
  }
}
