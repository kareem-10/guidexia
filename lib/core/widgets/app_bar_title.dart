import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontSize: 27.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
