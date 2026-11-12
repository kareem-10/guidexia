import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/helpers/app_regex.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/core/widgets/app_text_form_field.dart';
import 'package:tourist_app/features/auth/view_model/login_cubit/login_cubit.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Form(
      key: cubit.signInFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email address',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),

          verticalSpace(8),

          AppTextFormField(
            controller: cubit.signInEmail,
            hintText: 'Enter your email',
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !AppRegex.isEmailValid(value.trim())) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          verticalSpace(24),

          Text(
            'Password',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),

          verticalSpace(8),

          AppTextFormField(
            controller: cubit.signInPassword,
            hintText: 'Enter your password',
            isObscureText: obscurePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => obscurePassword = !obscurePassword);
              },
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
