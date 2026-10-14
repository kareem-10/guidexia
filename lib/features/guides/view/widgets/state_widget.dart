import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/utils/app_colors.dart';

// ignore: must_be_immutable
class StatWidget extends StatelessWidget {
  StatWidget({super.key, required this.value, required this.label});
  String value;
  String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(fontSize: 11.sp, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
