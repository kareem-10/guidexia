import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/place_details/view/widgets/details_section_title.dart';

class TagsSection extends StatelessWidget {
  final List<String> tags;

  const TagsSection({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DetailsSectionTitle(
          title: 'Explore its highlights',
          subtitle: 'Discover what this place has to offer.',
        ),

        verticalSpace(13),

        Wrap(
          spacing: 9.w,
          runSpacing: 9.h,
          children: tags.map((tag) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: scheme.primary,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
