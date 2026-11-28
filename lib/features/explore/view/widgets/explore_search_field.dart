import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ExploreSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(17.r),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: scheme.primary,
        style: TextStyle(color: scheme.onSurface, fontSize: 13.sp),
        decoration: InputDecoration(
          hintText: 'Where do you want to explore?',
          hintStyle: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12.sp),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: scheme.primary,
            size: 23.sp,
          ),
          suffixIcon: Icon(
            Icons.tune_rounded,
            color: scheme.onSurfaceVariant,
            size: 20.sp,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 17.h),
        ),
      ),
    );
  }
}
