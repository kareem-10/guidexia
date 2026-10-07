import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSection extends StatelessWidget {
  final String description;

  const AboutSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About this place',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 9.h),

        Text(
          description.isNotEmpty
              ? description
              : 'No description available for this place.',
          style: TextStyle(
            fontSize: 12.sp,
            height: 1.6,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
