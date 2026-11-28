import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';

class ExploreHeader extends StatelessWidget {
  const ExploreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DISCOVER',
          style: TextStyle(
            color: scheme.primary,
            fontSize: 10.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.5,
          ),
        ),
        verticalSpace(7),
        Text(
          'Explore the world.',
          style: textTheme.headlineMedium?.copyWith(
            fontSize: 29.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        verticalSpace(5),
        Text(
          'Find your next unforgettable destination.',
          style: textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
