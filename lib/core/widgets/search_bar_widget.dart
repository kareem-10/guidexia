import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/utils/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;
  final String? hintText;

  const SearchBarWidget({
    super.key,
    this.controller,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.5)),
      ),
      child: TextField(
        cursorColor: AppColors.primaryColor,
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: AppColors.grey, size: 22.sp),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: AppColors.primaryColor.withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
    );
  }
}
