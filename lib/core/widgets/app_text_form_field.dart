import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: scheme.primary, width: 1.3),
              borderRadius: BorderRadius.circular(16.0),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: scheme.outline, width: 1.3),
              borderRadius: BorderRadius.circular(16.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.error, width: 1.3),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.error, width: 1.3),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintStyle:
            hintStyle ??
            textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? scheme.surfaceContainerHighest,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style:
          inputTextStyle ??
          textTheme.bodyMedium?.copyWith(
            color: scheme.primary,
            fontWeight: FontWeight.w500,
          ),
      validator: (value) {
        return validator(value);
      },
    );
  }
}
