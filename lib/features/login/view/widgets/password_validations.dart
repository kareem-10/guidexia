import 'package:flutter/material.dart';
import 'package:tourist_app/core/helpers/spacing.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow(context, 'At least 1 lowercase letter', hasLowerCase),
        verticalSpace(2),
        buildValidationRow(context, 'At least 1 uppercase letter', hasUpperCase),
        verticalSpace(2),
        buildValidationRow(
          context,
          'At least 1 special character',
          hasSpecialCharacters,
        ),
        verticalSpace(2),
        buildValidationRow(context, 'At least 1 number', hasNumber),
        verticalSpace(2),
        buildValidationRow(context, 'At least 8 characters long', hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(BuildContext context, String text, bool hasValidated) {
    final scheme = Theme.of(context).colorScheme;
    final success = scheme.brightness == Brightness.dark
        ? const Color(0xFF81C784)
        : const Color(0xFF2E7D32);
    return Row(
      children: [
        CircleAvatar(radius: 2.5, backgroundColor: scheme.onSurfaceVariant),
        horizontalSpace(6),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: hasValidated ? scheme.onSurfaceVariant : scheme.primary,
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: success,
            decorationThickness: 2,
          ),
        ),
      ],
    );
  }
}

