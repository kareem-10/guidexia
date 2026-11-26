import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';

class GuideCardInfo extends StatelessWidget {
  final GuideModel guide;
  const GuideCardInfo({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                guide.fullName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ),
            if (guide.isVerified)
              Icon(Icons.verified, color: scheme.primary, size: 17.sp),
          ],
        ),
        verticalSpace(4),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 15.sp,
              color: scheme.onSurfaceVariant,
            ),
            horizontalSpace(3),
            Expanded(
              child: Text(
                guide.location.isEmpty
                    ? 'Location not provided'
                    : guide.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(6),
        Row(
          children: [
            Icon(Icons.star_rounded, color: scheme.tertiary, size: 17.sp),
            horizontalSpace(3),
            Text(
              guide.averageRating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
            horizontalSpace(4),
            Text(
              '(${guide.reviewCount})',
              style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
            ),
          ],
        ),
        verticalSpace(7),
        Text(
          guide.specialties.isEmpty ? 'Tour guide' : guide.specialties,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.sp,
            color: scheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpace(8),
        Row(
          children: [
            Text(
              '${guide.experienceYears} yrs experience',
              style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
            ),
            const Spacer(),
            Text(
              '\$${guide.pricePerPerson.toStringAsFixed(0)}/person',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: scheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
