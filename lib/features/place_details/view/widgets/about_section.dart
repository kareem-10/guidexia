import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/place_details/view/widgets/details_section_title.dart';

class AboutSection extends StatelessWidget {
  final String description;

  const AboutSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DetailsSectionTitle(
          title: 'About this place',
          subtitle: 'Discover what makes this destination special.',
        ),

        verticalSpace(13),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(17.w),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Text(
            description.isNotEmpty
                ? description
                : 'No description available for this place.',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12.sp,
              height: 1.8,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ],
    );
  }
}
