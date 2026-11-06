import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.5)),
      ),
      child: TextField(
        cursorColor: scheme.primary,
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: scheme.onSurface),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: scheme.onSurfaceVariant,
            size: 22.sp,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 14.sp,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: scheme.primary.withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
    );
  }
}

