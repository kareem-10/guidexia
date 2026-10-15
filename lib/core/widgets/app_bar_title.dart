import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 27.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xFF242B31),
      ),
    );
  }
}
