import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/helpers/spacing.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';

class RatingSection extends StatelessWidget {
  final PlaceModel place;

  const RatingSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 54.w,
            height: 54.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFFC857).withValues(alpha: 0.17),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Icon(
              Icons.star_rounded,
              color: Color(0xFFFFB52E),
              size: 32,
            ),
          ),

          horizontalSpace(13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.averageRating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
                verticalSpace(3),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < place.averageRating.round()
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 13.sp,
                      color: const Color(0xFFFFB52E),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(width: 1, height: 42.h, color: scheme.outlineVariant),

          horizontalSpace(15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${place.reviewCount}',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),
              verticalSpace(3),
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
