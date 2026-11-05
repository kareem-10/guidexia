import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/theming/app_text_theme.dart';
import 'package:tourist_app/core/theming/font_weight_helper.dart';
import 'package:tourist_app/core/utils/app_colors.dart';

class TextStyles {
  static const String _fontFamily = AppTextTheme.fontFamily;

  static TextStyle font12GreyRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.grey,
    fontFamily: _fontFamily,
  );

  static TextStyle font14PrimaryMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.primaryColor,
    fontFamily: _fontFamily,
  );

  static TextStyle font12PrimaryRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.primaryColor,
    fontFamily: _fontFamily,
  );

  static TextStyle font12GreyMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.grey,
    fontFamily: _fontFamily,
  );

  static TextStyle font14GreyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.grey,
    fontFamily: _fontFamily,
  );

  static TextStyle font16WhiteSemiBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.lightOnPrimary,
    fontFamily: _fontFamily,
  );
}
