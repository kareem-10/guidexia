import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/theming/font_weight_helper.dart';

class AppTextTheme {
  AppTextTheme._();

  static const String fontFamily = 'Cairo';

  static TextTheme textTheme(ColorScheme colorScheme) {
    final base = TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeightHelper.bold,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeightHelper.bold,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeightHelper.bold,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.medium,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.regular,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.regular,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.regular,
        color: colorScheme.onSurfaceVariant,
        fontFamily: fontFamily,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.medium,
        color: colorScheme.primary,
        fontFamily: fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.medium,
        color: colorScheme.onSurfaceVariant,
        fontFamily: fontFamily,
      ),
      labelSmall: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeightHelper.regular,
        color: colorScheme.onSurfaceVariant,
        fontFamily: fontFamily,
      ),
    );
    return base;
  }
}
