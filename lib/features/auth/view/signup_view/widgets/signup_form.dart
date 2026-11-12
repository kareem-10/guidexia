import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/helpers/app_regex.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/widgets/app_text_form_field.dart';
import 'package:tourist_app/features/auth/view/signup_view/widgets/role_selector.dart';
import 'package:tourist_app/features/auth/view_model/signup_cubit/signup_cubit.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Form(
      key: cubit.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(context, 'First name'),
          verticalSpace(8),
          AppTextFormField(
            hintText: 'Enter your first name',
            controller: cubit.firstNameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'First name is required';
              }
              return null;
            },
          ),

          verticalSpace(18),

          _buildLabel(context, 'Last name'),
          verticalSpace(8),
          AppTextFormField(
            hintText: 'Enter your last name',
            controller: cubit.lastNameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Last name is required';
              }
            },
          ),

          verticalSpace(18),

          _buildLabel(context, 'Email address'),
          verticalSpace(8),
          AppTextFormField(
            hintText: 'Enter your email',
            controller: cubit.signUpEmail,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !AppRegex.isEmailValid(value.trim())) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          verticalSpace(18),

          _buildLabel(context, 'Password'),
          verticalSpace(8),
          _PasswordField(
            controller: cubit.signUpPassword,
            hintText: 'Create a password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (!AppRegex.hasMinLength(value) ||
                  !AppRegex.hasLowerCase(value) ||
                  !AppRegex.hasUpperCase(value) ||
                  !AppRegex.hasNumber(value) ||
                  !AppRegex.hasSpecialCharacter(value)) {
                return 'Password does not meet the requirements';
              }
              return null;
            },
          ),

          verticalSpace(12),

          _PasswordRequirements(passwordController: cubit.signUpPassword),

          verticalSpace(18),

          _buildLabel(context, 'Confirm password'),
          verticalSpace(8),
          _PasswordField(
            controller: cubit.signUpConfirmPassword,
            hintText: 'Confirm your password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != cubit.signUpPassword.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),

          verticalSpace(24),

          _buildLabel(context, 'I am a'),
          verticalSpace(12),

          const RoleSelector(),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;

  const _PasswordField({
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: widget.controller,
      hintText: widget.hintText,
      isObscureText: obscure,
      validator: widget.validator,
      suffixIcon: IconButton(
        onPressed: () => setState(() => obscure = !obscure),
        icon: Icon(
          obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        ),
      ),
    );
  }
}

class _PasswordRequirements extends StatefulWidget {
  final TextEditingController passwordController;

  const _PasswordRequirements({required this.passwordController});

  @override
  State<_PasswordRequirements> createState() => _PasswordRequirementsState();
}

class _PasswordRequirementsState extends State<_PasswordRequirements> {
  @override
  void initState() {
    super.initState();
    widget.passwordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.passwordController.removeListener(_onPasswordChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final password = widget.passwordController.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _requirement('8 characters minimum', AppRegex.hasMinLength(password)),
        _requirement('One uppercase letter', AppRegex.hasUpperCase(password)),
        _requirement('One lowercase letter', AppRegex.hasLowerCase(password)),
        _requirement('One number', AppRegex.hasNumber(password)),
        _requirement(
          'One special character',
          AppRegex.hasSpecialCharacter(password),
        ),
      ],
    );
  }

  Widget _requirement(String text, bool valid) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            valid ? Icons.check_circle : Icons.circle_outlined,
            size: 15,
            color: valid ? Colors.green : scheme.onSurfaceVariant,
          ),
          horizontalSpace(8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: valid ? Colors.green : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
